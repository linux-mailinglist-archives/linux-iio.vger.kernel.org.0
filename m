Return-Path: <linux-iio+bounces-6487-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A490D2E0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF88D1F21802
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F178615CD42;
	Tue, 18 Jun 2024 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zdXi1vLl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25C15B120
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717447; cv=none; b=B/TBAv4LDBZcRLt6FcgwEtWWRZZWdjnucnfhOsVdF5sX2N2cD7qMsDNgowcE6+VbntzS9PnDH8pXq0yKhggEX+r/JXRPfE6eWgYZ/UaqkasE3Z5LNQTDaY0hmsXUj5QAQOTL3dS9shRChC+TaNf63xtHNxH2C93BACsqK98tF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717447; c=relaxed/simple;
	bh=NKx10kZQVFlFekzvoEnS/8ZTj3H2HcjEG4LOYzcq8J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVCPZ+Z66uvvCdDQwIZbFOtBc/xlr6KJPxdjvtlnB/tguPLXjZPZ4feEkJcJXeK6Qs6OlJwGoZPJ+XWKuFB2+lXZZ4CbDeTJahbSIvVgIlhHy7MI8fwITQBTKwqP/qsFOX/wGw72vUB/DuKv0cnKPG7uAoIJmuKAprZVbKqdo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zdXi1vLl; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f98178ceb3so2979738a34.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 06:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718717443; x=1719322243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f27crG0t09naGQNeqsNy+BsT+aZ19Wc0lLslo+BFljo=;
        b=zdXi1vLlUyVvsUkhUOtqRrG3X0SC+KGPfUaWToQb42o75ANcbwpqGqz4BuryMHUb3K
         Z33yFiB4FX87EXpUmpsp6ByTWyLAMFjKzDLGQojNwzNEAxuGhnA8edWvhuyV66gM7vzG
         NcWRPqYTMC6aZRblqRPmTwHvphgruoYN9+/dYZ9Ym8f55JyUfmlLVfWXFatyrSTTfwzP
         QzMKPqc5E9Z2puwse1epvt9wNAuvtS/L+a4KODS8/+fgtfCCOl/XiMxEp2wQniDKwoXA
         bP0nngZhc92JAfZg0xVt7PxCvqZzVgbc+GhzfIk5FzBTDP+sZsPFQvMYkU1CQrCD6oks
         XSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717443; x=1719322243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f27crG0t09naGQNeqsNy+BsT+aZ19Wc0lLslo+BFljo=;
        b=GmU8l1chlQOGLJ4NGWSNLBctv727C48kUAqizGDL7dOQYHOlC0/EUIrSrXIcbO4Kgq
         gPlqrYl4C8UoQwOUw0L/WWGiisMu0KY8sXOCSarI9w8dYft6zD4LH1eiXLp/2LnkTZ/5
         ExCgVe+grwNkV38RW5yomWKelBNCEuSqd0CBAheyPe27+ofB3Yso68ptMC3BKdv5KXd9
         D+WcEgoYNzV8YxPPazCfTQ+KDOLqtMLZj9w1etGudxnJm+3Tr6xsZtCokXz8a7hImuac
         4573EFpYos+lxOYIoVmCxLAgV5GTd8khytJYG/uDPNccxD0cwv4gFjHAT/lccDVwP2w5
         LdHA==
X-Forwarded-Encrypted: i=1; AJvYcCWFSawM1ntWWxvbnwaiQV5R++Le+eYY7SX9l2eI5Hoxg7a0UEZh7FUzN9txIr1f2NhiZNXzrGY0oj4bMJgpYJ8gynxgfEkItNZZ
X-Gm-Message-State: AOJu0YwxRYn7PeFQKwS10UW99KN9SH5USf7Fuwm45xdTz8PRgHN0ViWu
	A+Lz++dKSH2JwgYdjE8/lJfucyxUMEBEmeiRCk/Q7ODHP4Xc5qWXIXIq6Y/Jh/8=
X-Google-Smtp-Source: AGHT+IGlgHuH6Aw7v0tedxzwDuhuIOOJp2cZSe2PENNmwz2c4i4yr/2Alb9Dd3EQ4ME8LxTLWFRfYg==
X-Received: by 2002:a9d:6392:0:b0:6f9:64df:c67d with SMTP id 46e09a7af769-6fb93b19710mr12842240a34.36.1718717442797;
        Tue, 18 Jun 2024 06:30:42 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5b1afdc3sm1828177a34.19.2024.06.18.06.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:30:42 -0700 (PDT)
Message-ID: <791cd07d-de03-4f37-b00e-f4c67a9e9c76@baylibre.com>
Date: Tue, 18 Jun 2024 08:30:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei>
 <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
 <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
 <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com>
 <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
 <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
 <CAMknhBE=fEDdYPe1VeZwWWuvqf5TcUdM_LQGOugHCxGhSGP8-w@mail.gmail.com>
 <bbc2f159-d673-4652-a6b9-a528f905b67c@gmail.com>
 <4ff58005-4a71-491f-9400-cdecf2c25d66@baylibre.com>
 <f338f479-edfc-462f-9c27-d025c85a5eec@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <f338f479-edfc-462f-9c27-d025c85a5eec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/24 4:45 AM, Alisa-Dariana Roman wrote:
> On 17.06.2024 23:00, David Lechner wrote:
> ...
> 
>>
>> We could make a ret2 local variable inside of the if block to avoid writing over ret.
>>
> 
> Nice! If this looks alright, I will send it along my updated series.
> 
> From f84206b85b04f89d57b9293dd93e017efe8b350c Mon Sep 17 00:00:00 2001
> From: David Lechner <dlechner@baylibre.com>
> Date: Wed, 12 Jun 2024 16:03:05 -0500
> Subject: [PATCH] iio: adc: ad7192: use devm_regulator_get_enable_read_voltage
> 
> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Error messages have changed slightly since there are now fewer places
> where we print an error. The rest of the logic of selecting which
> supply to use as the reference voltage remains the same.
> 
> Also 1000 is replaced by MILLI in a few places for consistency.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad7192.c | 101 +++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index c7fb51a90e87..2448b01e0d59 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -200,8 +200,6 @@ struct ad7192_chip_info {
> 
>  struct ad7192_state {
>      const struct ad7192_chip_info    *chip_info;
> -    struct regulator        *avdd;
> -    struct regulator        *vref;
>      struct clk            *mclk;
>      u16                int_vref_mv;
>      u32                aincom_mv;
> @@ -1189,18 +1187,12 @@ static const struct ad7192_chip_info ad7192_chip_info_tbl[] = {
>      },
>  };
> 
> -static void ad7192_reg_disable(void *reg)
> -{
> -    regulator_disable(reg);
> -}
> -
>  static int ad7192_probe(struct spi_device *spi)
>  {
>      struct device *dev = &spi->dev;
>      struct ad7192_state *st;
>      struct iio_dev *indio_dev;
> -    struct regulator *aincom;
> -    int ret;
> +    int ret, ret2, avdd_mv;
> 
>      if (!spi->irq)
>          return dev_err_probe(dev, -ENODEV, "Failed to get IRQ\n");
> @@ -1218,72 +1210,47 @@ static int ad7192_probe(struct spi_device *spi)
>       * Newer firmware should provide a zero volt fixed supply if wired to
>       * ground.
>       */
> -    aincom = devm_regulator_get_optional(dev, "aincom");
> -    if (IS_ERR(aincom)) {
> -        if (PTR_ERR(aincom) != -ENODEV)
> -            return dev_err_probe(dev, PTR_ERR(aincom),
> -                         "Failed to get AINCOM supply\n");
> -
> -        st->aincom_mv = 0;
> -    } else {
> -        ret = regulator_enable(aincom);
> -        if (ret)
> -            return dev_err_probe(dev, ret,
> -                         "Failed to enable specified AINCOM supply\n");
> -
> -        ret = devm_add_action_or_reset(dev, ad7192_reg_disable, aincom);
> -        if (ret)
> -            return ret;
> -
> -        ret = regulator_get_voltage(aincom);
> -        if (ret < 0)
> -            return dev_err_probe(dev, ret,
> -                         "Device tree error, AINCOM voltage undefined\n");
> -        st->aincom_mv = ret / MILLI;
> +    ret = devm_regulator_get_enable_read_voltage(dev, "aincom");
> +    if (ret < 0 && ret != -ENODEV)
> +        return dev_err_probe(dev, ret, "Failed to get AINCOM voltage\n");
> +
> +    st->aincom_mv = ret == -ENODEV ? 0 : ret / MILLI;
> +
> +    /* AVDD can optionally be used as reference voltage */
> +    ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> +    if (ret == -ENODEV || ret == -EINVAL) {

               int ret2;

I would declare ret2 here since it is the only place it is used.

> +        /*
> +         * We get -EINVAL if avdd is a supply with unknown voltage. We
> +         * still need to enable it since it is also a power supply.
> +         */
> +        ret2 = devm_regulator_get_enable(dev, "avdd");
> +        if (ret2)
> +            return dev_err_probe(dev, ret2,
> +                         "Failed to enable AVDD supply\n");
> +    } else if (ret < 0) {
> +        return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
>      }
> 
> -    st->avdd = devm_regulator_get(dev, "avdd");
> -    if (IS_ERR(st->avdd))
> -        return PTR_ERR(st->avdd);
> -
> -    ret = regulator_enable(st->avdd);
> -    if (ret)
> -        return dev_err_probe(dev, ret,
> -                     "Failed to enable specified AVdd supply\n");
> -
> -    ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->avdd);
> -    if (ret)
> -        return ret;
> +    avdd_mv = (ret == -ENODEV) | (ret == -EINVAL) ? 0 : ret / MILLI;

This could be simplified to ret < 0.

Or if you want to leave it explicit, use || instead of |.

And () aren't really needed either.

> 
>      ret = devm_regulator_get_enable(dev, "dvdd");
>      if (ret)
>          return dev_err_probe(dev, ret, "Failed to enable specified DVdd supply\n");
> 
> -    st->vref = devm_regulator_get_optional(dev, "vref");
> -    if (IS_ERR(st->vref)) {
> -        if (PTR_ERR(st->vref) != -ENODEV)
> -            return PTR_ERR(st->vref);
> -
> -        ret = regulator_get_voltage(st->avdd);
> -        if (ret < 0)
> -            return dev_err_probe(dev, ret,
> -                         "Device tree error, AVdd voltage undefined\n");
> -    } else {
> -        ret = regulator_enable(st->vref);
> -        if (ret)
> -            return dev_err_probe(dev, ret,
> -                         "Failed to enable specified Vref supply\n");
> -
> -        ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->vref);
> -        if (ret)
> -            return ret;
> -
> -        ret = regulator_get_voltage(st->vref);
> -        if (ret < 0)
> -            return dev_err_probe(dev, ret,
> -                         "Device tree error, Vref voltage undefined\n");
> +    /*
> +     * This is either REFIN1 or REFIN2 depending on adi,refin2-pins-enable.
> +     * If this supply is not present, fall back to AVDD as reference.
> +     */
> +    ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +    if (ret == -ENODEV) {
> +        if (avdd_mv == 0)
> +            return dev_err_probe(dev, -ENODEV,
> +                         "No reference voltage available\n");
> +    } else if (ret < 0) {
> +        return ret;
>      }
> -    st->int_vref_mv = ret / 1000;
> +
> +    st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
> 
>      st->chip_info = spi_get_device_match_data(spi);
>      indio_dev->name = st->chip_info->name;


