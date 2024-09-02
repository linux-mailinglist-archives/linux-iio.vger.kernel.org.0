Return-Path: <linux-iio+bounces-8979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C79685AD
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDB1285341
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC714A092;
	Mon,  2 Sep 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="WLacHvz/"
X-Original-To: linux-iio@vger.kernel.org
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0613C810;
	Mon,  2 Sep 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275081; cv=none; b=e06eHLKkW4bCAnMZgIAEBE+JzRDcN0juqkK7e33PzbV2CGXP+TLbozJ/htF5Zh3lSooESljXEXAJ1lPKPQPhS+rjjxE+AT/AJHBlNQa/6BduaNKeHvPI3XrJdzBqTMwR8OJTgaNw5XGAl/lvvP2PTTVdvxLYvoLupQZyHJN42f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275081; c=relaxed/simple;
	bh=EE8fo0xV2sVsTfrR/ysjBjJNENwSiQnPCm4dDGYdiNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwGUNeqq6Z9xvDt37BweOcniuHF2tB0FT8WZ5OAu5616F/HnqUSn/+RdYs685U+/5kUplx7OBRKaFwfmVU/sqEE956Qg/CAq5jqbQwnuo7WNKC9tD/hvT5YxhsJ5dp5LhtRDIrhZpcMpYhDIRIAFdQfCmq207OI7XUdOPkNGW0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=WLacHvz/; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=t1uvNNj/PeO6tL7UteiTv0T9DTrMfCU93Ae13Fcw+qs=; b=WLacHvz/tCJMv8FRkF0KyDgtaG
	o9muD+powxtEW15a8Lm8zCQtI2uJe9bmEFSmFJuI+NMJyakv0hwmpLpx6h7txvTxOmsdWTh+Wd4Cc
	/JfvR1S1zCSXoSDxLvrty0Zo3r/R64uOivOBkfsYjwWgRfMB6wrESpDiw2zhDYR2A/EJ7d1Y1FEE/
	KkWc77CElHHPaGd6VPyQTVh0N+vMPvt1qAL1IqpFmPBYJpKR0KSdr4s7ACdco1+RO8jj5E/gqhhYU
	gSA+tQAXeom9dqumruXFnPeHmn6Vm+aWu1hghE6OWmTKR338GHXZWd0HXmNJ4JwXiEZr5JMPWldQ2
	INpUye1Q==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1sl4X3-000EVO-7K; Mon, 02 Sep 2024 12:43:37 +0200
Received: from [199.175.221.143] (helo=[192.168.178.88])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1sl4X2-000JwP-2B;
	Mon, 02 Sep 2024 12:43:37 +0200
Message-ID: <e2106a4f-ed3a-4b02-b1d2-d54c096fcab8@metafoo.de>
Date: Mon, 2 Sep 2024 12:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: proximity: hx9023s: Use 'CLOCK_BOOTTIME' as the
 default clock source
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: jic23@kernel.org, dan.carpenter@linaro.org, nuno.sa@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240902103210.31369-1-yasin.lee.x@gmail.com>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240902103210.31369-1-yasin.lee.x@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27386/Mon Sep  2 10:35:36 2024)

On 9/2/24 12:32, Yasin Lee wrote:
> Override the default (CLOCK_REALTIME) clock source to 'CLOCK_BOOTTIME'.
Why? Won't this break existing applications that rely on the current 
default?
>
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>   drivers/iio/proximity/hx9023s.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index 8b9f84400e00..5363357a9a46 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -1074,6 +1074,10 @@ static int hx9023s_probe(struct i2c_client *client)
>   					     "iio trigger register failed\n");
>   	}
>   
> +	ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "clock boottime set failed\n");
> +
>   	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>   					      iio_pollfunc_store_time,
>   					      hx9023s_trigger_handler,



