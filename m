Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFED010D8DB
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfK2RXl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 12:23:41 -0500
Received: from www381.your-server.de ([78.46.137.84]:47880 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2RXk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 12:23:40 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1iajzW-00039E-MN; Fri, 29 Nov 2019 18:23:38 +0100
Received: from [93.104.121.45] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1iajzW-0006Ai-FQ; Fri, 29 Nov 2019 18:23:38 +0100
Subject: Re: iio_compute_scan_bytes does not seem to account for alignment if
 first channel uses more storagebits than its successors
To:     =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>,
        linux-iio@vger.kernel.org
References: <ff5a3ea4-4d15-5be3-9cb8-9fd7c716e2e6@plating.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fef18238-85cc-00e7-ee7d-a52c62509c22@metafoo.de>
Date:   Fri, 29 Nov 2019 18:23:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ff5a3ea4-4d15-5be3-9cb8-9fd7c716e2e6@plating.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25648/Fri Nov 29 10:44:54 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/29/19 3:30 PM, Lars Möllendorf wrote:
> Hi,
> 
> I have written a custom kernel module implementing the IIO device API
> backed by an IIO triggered buffer.
> 
> My IIO device provides 3 channels + timestamp. The sizes of the channels are
> 
> index  | iio_chan_spec.scan_type.storagebits
> -------|------------------------------------------------
>    0   |  32
>    1   |  16
>    2   |  16
> 
> If I select channel 0 (32bit) and one of channel 1 or 2 (16bit)
> indio_dev.scan_bytes and iio_buffer.bytes_per_datum have a value of 6
> Byte which does not account for any alignment.
> 
> 
> After having a closer look at  `iio_compute_scan_bytes` which is
> responsible for calculating both, `indio_dev.scan_bytes` and
> `iio_buffer.bytes_per_datum` it seems to me that the order of channels
> matter:
> 
> ```c
> 	/* How much space will the demuxed element take? */
> 	for_each_set_bit(i, mask,
> 			 indio_dev->masklength) {
> 		length = iio_storage_bytes_for_si(indio_dev, i);
> 		bytes = ALIGN(bytes, length);
> 		bytes += length;
> 	}
> ```
> 
> I understand that in case the length of each scan element is smaller
> then the length of the successive scan elements, this algorithm works
> because it aligns the current element to its own length. But if, as in
> my case, the length of channel 0's scan elements  is greater then the
> size of the samples of the consecutive channels no alignment seems to be
> taken into account. Do I miss something here?
[...]
> But in my case the latter would bloat the buffer from 16 Byte to 4*16 =
> 64 Byte per scan if all channels are selected and timestamp is active.
> 
> For now, I will work around this by using 32 storagebits for all my
> channels. This gives my 4 Bytes of overhead per scan if all elements are
> selected and additional 2 Byte if timestamp is active.
> 
> In "Why do you align the buffer pointer to a multiple of the size of the
> current scan element in iio_buffer_foreach_sample()?" on
> https://github.com/analogdevicesinc/libiio/issues/324 I have been
> pointed to this mailing list.

Hi Lars,

The way this is supposed to work is that each element is aligned to its
own natural alignment. What seems to be missing at the moment is that
the total length is also aligned to the size of the first element, so
that alignment is preserved for multiple consecutive samples. I feel
like we had that at some point, but maybe I'm misremembering.

E.g. putting something like

 unsigned int first_index = find_first_bit(mask, indio_dev->masklength);
 length = iio_storage_bytes_for_si(indio_dev, first_index);
 bytes = ALIGN(bytes, length);

below the loop should do the trick I believe.

- Lars

