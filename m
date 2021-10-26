Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE6543ACAD
	for <lists+linux-iio@lfdr.de>; Tue, 26 Oct 2021 09:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhJZHML (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Oct 2021 03:12:11 -0400
Received: from www381.your-server.de ([78.46.137.84]:35550 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhJZHML (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Oct 2021 03:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=bAiPxkcq1Y6Mqy9Co7oacNf9Gp/96uAvHuTosH8SVn8=; b=e6ySv/d3AfLHaWHUfsV1w+aD1f
        aJ64bJG+MTy+J6h4GZTZnz2Ro34fWref2PVQWpPVhI302oVkjWts7qDmKb8r2t7pIhD0JJkC9q/Cd
        KCuZ41I/4hj0SBwqDqkseCyaBkZYZd2AN62DFvlPHrrKl4t6/Xl/EPo1z9TCr9rBdCTtv4rS+Fiom
        uzg9KxN2Qdd3xj3iBs18uJJhqyQCkRRsmuKubV1s83GqhR9hQB/+GBB9a2DXpXA1j9aKKRpUwEQ6/
        ML5oPt/CMqFC6pDjPbmo75oATVYKjD/zgfilruen4XM1eNA2UbU9TACT92VeJFs88jlIjn1q5K2gy
        7sqIW8mA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mfGaf-000DW6-3j; Tue, 26 Oct 2021 09:09:45 +0200
Received: from [82.135.83.71] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mfGae-000UaZ-R6; Tue, 26 Oct 2021 09:09:44 +0200
Subject: Re: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
To:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        linux-kernel@vger.kernel.org, jic23@kernel.org,
        linux-iio@vger.kernel.org, git@xilinx.com, michal.simek@xilinx.com,
        pmeerw@pmeerw.net, devicetree@vger.kernel.org
Cc:     Manish Narani <manish.narani@xilinx.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
 <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <03afaedd-8ea5-0379-ac98-db61ac679259@metafoo.de>
Date:   Tue, 26 Oct 2021 09:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26333/Mon Oct 25 10:29:40 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/19/21 5:20 PM, Anand Ashok Dumbre wrote:
> [...]
> +#define AMS_CHAN_TEMP(_scan_index, _addr) { \
> +	.type = IIO_TEMP, \
> +	.indexed = 1, \
> +	.address = (_addr), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_SCALE) | \
> +		BIT(IIO_CHAN_INFO_OFFSET), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
There is no handling of IIO_CHAN_INFO_SAMP_FREQ in read_raw(). Reading 
the sampling_frequency attribute always returns -EINVAL.
> +	.event_spec = ams_temp_events, \
> +	.scan_index = _scan_index, \
> +	.num_event_specs = ARRAY_SIZE(ams_temp_events), \
> +}
> +
> +#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _alarm) { \
> +	.type = IIO_VOLTAGE, \
> +	.indexed = 1, \
> +	.address = (_addr), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +		BIT(IIO_CHAN_INFO_SCALE), \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.event_spec = (_alarm) ? ams_voltage_events : NULL, \
> +	.scan_index = _scan_index, \
> +	.num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
> +}
