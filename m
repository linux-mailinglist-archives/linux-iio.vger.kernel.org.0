Return-Path: <linux-iio+bounces-11713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06B9B801B
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 17:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE0A285443
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771CB1CB329;
	Thu, 31 Oct 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q5M/Oj9i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6D1CB324
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392071; cv=none; b=mib9hHgwgBSAbPPBqsf+mbNuny/f0ZSmgtC+fNjNC+xGbsTu7py+nyJvpGksVl9Cd9SozvWYXODI2pDcqrnwSNQa8db2EeoINl67ITH7o5eQkt/ZYSnNIdSCAmExLvFhV4LekcmlB2eAqzwerSbFNxvPU2iUNQ5YsChcDswM844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392071; c=relaxed/simple;
	bh=NXkq/qyOqhp8iiSocyYd5F4iMl9dEpzBnig3MAjD1ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/BKE3Nkmm70qUVhgxz7AsLQEEVCw9UCC2CgQz0OD3077iNOiiRPE1QtFFZqqii3Ky0TmjPlKPa9MN99ssU6jJL7B/LPiqekG7EjbMySAK+6lYxEj3U8J+E177kA+t/3u4aufL7q1Wj04yI1R7Z4RtW9IHU9E4cWKYH+0hxnSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q5M/Oj9i; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71807ad76a8so579446a34.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730392068; x=1730996868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zkuoswXbu0x76VZ9dkSgVo5XUz825DeoWuELNa3+zU=;
        b=q5M/Oj9i+XqVZc0GrEkuCxFJfj8OZBgHXw0lBI/odPbQvz4o76tGKXZ4a98Oj95Teg
         NE7qbtFqX/M5poFVVX00GCuUc69wAYNMwdGETpLXaJ1QXGVqDpxJLHoFY3H5wMYng6ol
         Ufd8lUxtTEhXq/QniyAhaBB7CfeIhcohnWOSmqB1Rnqxf2BBMgv+p/6lw6+CEb4aWP2O
         4OswJ5tyDTDxjLZk6/L7gHOL1Hkuem9de0eMx9Kjk/R/qjazmik86pMeMmUuheJ5SLKI
         oa6QbxVUhTFyBAe1GhljdsPsUpnAmh42AUOaTHrmc/kzdcFG8/lA1rHO1VImy0O2btvW
         2fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730392068; x=1730996868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zkuoswXbu0x76VZ9dkSgVo5XUz825DeoWuELNa3+zU=;
        b=QZk4Gwpy3YuTGkHrAuOe6l01SO5FzzmcfqBEiPqtYIRKdofi8Ig32NMgURlR4/Edes
         C/X6gdi61DeIzZTmlzR1BwTmwYHR7oS3BpBH6THUa5hPg9eKGZDNe+OS+B3bMnu96CV5
         PEswF1ZZzm6MgnGsf1I4RlLx1H1HTa2tZMledA7b/qDcwphFeDmmYrTCvxUPEN5cyfzv
         jWSAQSDWrzxJamGg+Ox0rL26Knn+hT2AyPwoR+kyCfxkkZhht7lRNSGRZy0CJHTthMR1
         2WTGTLsVJW2zzqEj5+5ryBcmej0LK8p3seqMl0BRHeJ8BtN4Khh+ic9tr5dj7r1w1rE8
         HEgQ==
X-Gm-Message-State: AOJu0YynD3t88Xg9Zby/Mw2pp6I/a5IaZdtlwqX7sF2dEVaXOkg0KeLa
	J+C2fu8CAMde2ouMfOmv7hqiZVZXvioHJCY+K7Y1n+WqqTMUqGDJIpbGHDv+oDs=
X-Google-Smtp-Source: AGHT+IGn3VcXN2vRbd8Rr0640Qt+w79Jerb9SkZNzmKhPFUbewiTnVqw/wQKsRc9oFeGGtT+FubdUQ==
X-Received: by 2002:a05:6830:4123:b0:718:43b6:b0a0 with SMTP id 46e09a7af769-7189b4b76edmr3540707a34.4.1730392067759;
        Thu, 31 Oct 2024 09:27:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc69b1dsm402044a34.18.2024.10.31.09.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 09:27:47 -0700 (PDT)
Message-ID: <ef4fe230-b7fb-4f7e-9173-ae85d305e9ae@baylibre.com>
Date: Thu, 31 Oct 2024 11:27:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] iio: light: adux1020: write_event_config: use
 local variable for interrupt value
To: Julien Stephan <jstephan@baylibre.com>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Cosmin Tanislav <cosmin.tanislav@analog.com>,
 Ramona Gradinariu <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Dan Robertson <dan@dlrobertson.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
 Michal Simek <michal.simek@amd.com>, Mariel Tinaco
 <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Kevin Tsai <ktsai@capellamicro.com>, Linus Walleij
 <linus.walleij@linaro.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-6-2bcacbb517a2@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 10:27 AM, Julien Stephan wrote:
> state parameter is currently an int, but it is actually a boolean.
> iio_ev_state_store is actually using kstrtobool to check user input,
> then gives the converted boolean value to write_event_config.  The code
> in adux1020_write_event_config re-uses state parameter to store an
> integer value. To prepare for updating the write_event_config signature
> to use a boolean for state, introduce a new local int variable.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/iio/light/adux1020.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index 2e0170be077aef9aa194fab51afbb33aec02e513..db57d84da616b91add8c5d1aba08a73ce18c367e 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -505,7 +505,7 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
>  				       enum iio_event_direction dir, int state)
>  {
>  	struct adux1020_data *data = iio_priv(indio_dev);
> -	int ret, mask;
> +	int ret, mask, val;
>  
>  	mutex_lock(&data->lock);
>  
> @@ -526,12 +526,12 @@ static int adux1020_write_event_config(struct iio_dev *indio_dev,
>  			mask = ADUX1020_PROX_OFF1_INT;
>  
>  		if (state)
> -			state = 0;
> +			val = 0;
>  		else
> -			state = mask;
> +			val = mask;
>  
>  		ret = regmap_update_bits(data->regmap, ADUX1020_REG_INT_MASK,
> -					 mask, state);
> +					 mask, val);
>  		if (ret < 0)
>  			goto fail;
>  
> 

Instead of introducing `val`, I would rewrite this as:

	if (state)
		ret = regmap_clear_bits(...);
	else
		ret = regmap_set_bits(...);




