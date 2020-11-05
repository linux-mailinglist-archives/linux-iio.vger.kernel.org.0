Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000122A7B4F
	for <lists+linux-iio@lfdr.de>; Thu,  5 Nov 2020 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKEKKB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Nov 2020 05:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgKEKKB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Nov 2020 05:10:01 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D61C52087D;
        Thu,  5 Nov 2020 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604571000;
        bh=e43ACLiVYQ1Ky7TXvo0FuFcYIPUjkV4Wu4xAqv0GG0k=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=zAlqXIRZwXtAkg5sz4m0NxeUq0913n0GkEVZAhdoArsrXMNochB9HMCSZ1IvWm+vt
         g02d7RFEuc/coS2s5hTrOv78vwAYkPrIB4T0Pc5g5de18R070hSKd5QKM7oZPXuqSV
         3jh9kYDKhPfjRQRyTbzH/wJY/fCwLJpV11IJWBOo=
Date:   Thu, 5 Nov 2020 11:09:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Pablo Ceballos <pceballos@google.com>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-hub: Fix issue with devices with no
 report ID
In-Reply-To: <20201103002939.688690-1-pceballos@google.com>
Message-ID: <nycvar.YFH.7.76.2011051109490.18859@cbobk.fhfr.pm>
References: <20201103002939.688690-1-pceballos@google.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Nov 2020, Pablo Ceballos wrote:

> Some HID devices don't use a report ID because they only have a single
> report. In those cases, the report ID in struct hid_report will be zero
> and the data for the report will start at the first byte, so don't skip
> over the first byte.
> 
> Signed-off-by: Pablo Ceballos <pceballos@google.com>
> ---
>  drivers/hid/hid-sensor-hub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 94c7398b5c27..3dd7d3246737 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -483,7 +483,8 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
>  		return 1;
>  
>  	ptr = raw_data;
> -	ptr++; /* Skip report id */
> +	if (report->id)
> +		ptr++; /* Skip report id */
>  

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

