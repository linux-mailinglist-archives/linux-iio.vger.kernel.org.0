Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB796E699D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Apr 2023 18:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjDRQe2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Apr 2023 12:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjDRQe0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Apr 2023 12:34:26 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B74BBB2
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 09:34:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso4049323a12.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Apr 2023 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681835664; x=1684427664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oIFKPLBODqM+PzUpjfAu1hIVbXjOylONsSo47WP2F8=;
        b=pjq7HLfctmKkroWFE6ViMBK8oK0QM+Dh9Nz2t/No92ziYsQJJyn9N2s3SiTD/84OvA
         8Gm27mPBoJJLqxA5LsAy4Yn75sAecBfx+CTtayUZgeweFyZoaCaWh/3aDTtDnXFWp4G6
         xZq5hzNoClRLEiZ83jAoI0xY7b3shpYhbvbiyEe7cm6D7bsdE8kzs/YGvly2nX6DfNgY
         0vJ93LSY7INJzRiVLVNqTBx0npmTwE6oIFXmDeSZtKGd7+rfrJC2aCVFqYz2lT7qX/bR
         v9qSseoAlMOhII6EUAB8nAlWMB6fRPNXBtnCn7PGFKaQeVC0uce5lY/5k+DREKQbFknO
         zZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681835664; x=1684427664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oIFKPLBODqM+PzUpjfAu1hIVbXjOylONsSo47WP2F8=;
        b=W2fbo0iTn9hQw9LXJClGrlSo8wZG05ZkRyFIBHe8d1VjNuRhpj0JXEpjcV3YCHIb6Y
         dEWOuvsjcZx+mRJtOhGnavPSILXHlzZnI/lN5XVGv5NWeWM3J5C2pTupHMa6WLNoKcr9
         5/OvFxD6+h2XLPjdlRSqwTOaKJfZ0kJVtKBvNDyTFEK9MA1tTlGlYQUq/eCHiTWsBB6i
         CWIO2SxizU08w5jTgRjlICTrPqM9LDnYi1pc56Qon82GOyKtsJcD3ioljlGLsZgiKJRd
         G82LEH1py36nCdNFbr3RGin1IfPvqbIX8NmUoPS6aPWJ4a2R9+FNxeTWzXGwNq0Dhy3I
         u9pw==
X-Gm-Message-State: AAQBX9c+ytkk/mlXWImcN3KI84m10aoLYkCo4o4SHXk387fv5UwmoV3e
        2j8KMZC4w9hDlp6VNtULoZuNJw==
X-Google-Smtp-Source: AKy350ZcGdS2ld20+tmquecSTNC8TNwlZQjxvSvV7h1YVX7Os4BwdWf2HH4O46iq+Y71LeJq0rjquw==
X-Received: by 2002:a05:6402:150f:b0:504:a2e5:d951 with SMTP id f15-20020a056402150f00b00504a2e5d951mr2683856edw.13.1681835663796;
        Tue, 18 Apr 2023 09:34:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id y2-20020aa7ccc2000000b004c2158e87e6sm7124039edt.97.2023.04.18.09.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:34:23 -0700 (PDT)
Message-ID: <72d5b078-da9e-ccbb-1557-9cacaea68e8d@linaro.org>
Date:   Tue, 18 Apr 2023 18:34:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] iio: light: Add support for TI OPT4001 light sensor
Content-Language: en-US
To:     Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230323-add-opt4001-driver-v1-0-1451dcc1bc8a@axis.com>
 <20230323-add-opt4001-driver-v1-2-1451dcc1bc8a@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323-add-opt4001-driver-v1-2-1451dcc1bc8a@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/04/2023 11:07, Stefan Windfeldt-Prytz wrote:
> This driver uses the continuous mode of the chip and integration
> time can be configured through sysfs.
> The constants for calculating lux value differs between packaging
> so it uses different compatible string for the two versions
> "ti,opt4001-picostar" and "ti,opt4001-sot-5x3" since the device id
> is the same.

Thank you for your patch. There is something to discuss/improve.

> +
> +	indio_dev->channels = opt4001_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(opt4001_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = chip->client->name;
> +
> +	of_id = of_match_device(of_match_ptr(opt4001_of_match), &client->dev);

? Drop of_match_ptr

> +	chip->package_constants = of_id->data;
> +
> +	ret = opt4001_load_defaults(chip);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set sensor defaults\n");
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +static void opt4001_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct opt4001_chip *chip = iio_priv(indio_dev);
> +
> +	opt4001_power_down(chip);
> +}
> +
> +static struct i2c_driver opt4001_driver = {
> +	.driver = {
> +		.name = "opt4001",
> +		.of_match_table = of_match_ptr(opt4001_of_match),

This should sparkle some warnings. Drop of_match_ptr().

Best regards,
Krzysztof

