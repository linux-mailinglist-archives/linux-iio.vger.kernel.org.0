Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C177AE48A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfIJHR1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 03:17:27 -0400
Received: from first.geanix.com ([116.203.34.67]:60688 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfIJHR1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Sep 2019 03:17:27 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id DC33063F8C;
        Tue, 10 Sep 2019 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568099814; bh=aUmlGRD7s/8YP4O7hbJ34i47eXPMIc8IMEp8E2Y/9Rw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GN1CczuUe3c7Lb1qMTigsxCLypTCYoaJEMjQUieibQ0K3vhTdK9Nf+SQfy6MJpdtE
         IA6WDuQSJ6mAXAaC9+bxlwPYJ0tU2Q59OoTVh+ADc9I0z+V8GHHgcykFz3GcRuVqc2
         UOayLA6upanOhSrIflCfMdT2vSJYWVlgQDJSBe/syw7QfmR9HXbxMctPb4OmFCphjE
         +fxZ1zohNr7pspRO+eijsxKnoTvs5CDNphzgfLhN+ptMjGNp61rKjbDfv7inn+dbJn
         WTmNNsQmKCozy6J0dx/UeZh3+hX6OSvBnd6DsqtDtQL2mCBnjbn9QKN28uXtGY+j9z
         og9FN3TaeOhTg==
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
 <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
 <20190910071250.GA2712@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <58121fe6-067f-4515-3375-735ca7b41df6@geanix.com>
Date:   Tue, 10 Sep 2019 09:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190910071250.GA2712@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/09/2019 09.12, Lorenzo Bianconi wrote:
> probably a silly question..are you tracing the interrupt line with an
> oscilloscope or a logical analyser? If you dump interrupt counters in
> /proc/interrupts will you see an interrupt storm for the selected irq
> pin?
> 

Not a silly question ;-)

An Oscilloscope :-)
The interrupt counter is stopping.
If I switch to IRQ_TYPE_LEVEL_HIGH, (to test if additional readings of 
the event and FIFO registers would help. It results in interrupt storm 
and the line continues to stay high.

/Sean
