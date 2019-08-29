Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F7A2654
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2019 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfH2Spu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Aug 2019 14:45:50 -0400
Received: from www381.your-server.de ([78.46.137.84]:47742 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfH2Spt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2019 14:45:49 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1i3PQZ-0004Pa-Lv; Thu, 29 Aug 2019 20:45:47 +0200
Received: from [93.104.106.3] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1i3PQZ-000Kdh-Fo; Thu, 29 Aug 2019 20:45:47 +0200
Subject: Re: read_raw endianess
To:     Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-iio@vger.kernel.org
References: <3056697.yunu66HNpL@ws-140106>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <93354b98-0861-82b2-14b4-1ccb4c27cb79@metafoo.de>
Date:   Thu, 29 Aug 2019 20:45:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <3056697.yunu66HNpL@ws-140106>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25556/Thu Aug 29 10:25:39 2019)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/29/19 6:30 PM, Alexander Stein wrote:
> Hi,
> 
> I'm wondering which endianess read_raw shall be returned? E.g. when calling
>> cat /sys/bus/iio/devices/iio\:device2/in_voltage0_raw
> How much 'rawness' shall be returned? How shall i return my 14 Bit
> big-endian left-adjusted value stored in 16bits?

Hi,

The sysfs attributes always return data in host system endianess and
usually shifted so that the data is right-justified. So that the largest
value that you'll get is 2**N_BITS-1.

raw in this case only means that the data has not been converted to e.g.
a standard SI unit (like volt) since that will typically cause a loss of
precision and/or quantization errors.

- Lars

