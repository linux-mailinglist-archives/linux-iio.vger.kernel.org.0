Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D19B69F901
	for <lists+linux-iio@lfdr.de>; Wed, 22 Feb 2023 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBVQac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Feb 2023 11:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjBVQac (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Feb 2023 11:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824C13523
        for <linux-iio@vger.kernel.org>; Wed, 22 Feb 2023 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677083388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uyCGtBjlKwm91+mLgTVGxV6sOSFWKLivsnmDzpiazg4=;
        b=Lw3bWrsVwkn9mmrmVqQnEfkBUHojYbps/6BOpdgPbLdL0z6xn6weMtlYTA/qJHZtuAPn6q
        cAIAv+D/VqSunx00lqxK9EkkTSCrWdpLLbezFehVm4K71JCMnJP/gqgHsxnnC/zu1XnGs5
        WXIdI84RwSLpbbhgi9P4qoArojKxeTU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-u3UZ8eXKNEeRMp_Or41sxw-1; Wed, 22 Feb 2023 11:29:47 -0500
X-MC-Unique: u3UZ8eXKNEeRMp_Or41sxw-1
Received: by mail-ed1-f69.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so10654434edb.10
        for <linux-iio@vger.kernel.org>; Wed, 22 Feb 2023 08:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyCGtBjlKwm91+mLgTVGxV6sOSFWKLivsnmDzpiazg4=;
        b=JJ1ex+RH1YDGkHVTbuWKJcBE8zO8/hndkAqVHvJQ/S5ilOVLMV7vX1XkeMnSP05KnZ
         jaHRPCbTuEZm95pl2PT6dMvBemXDUo0sYu92egvwk6mD7hUym9skxg+L7zxnWnxENYUf
         vlg04ZnbTREVZXqt9kjkTQPf0GHi5rHgYi2HxALo0OCp7lI5zmWYcUPM5HQeP8nLWfFS
         6dZz+bXlCSvvgEu6YiDyzLIeiRI2ArlSZAALA0Fh7aZIaceipVaCz+CiirpP4Ev5/T17
         W8anjjHPfQOL29PkhQ/az1B1QAKLawvB7+6caUq4XKMgeJp9MngP1nyivnrYv3XjmgrA
         PzMw==
X-Gm-Message-State: AO0yUKVOwDbgXZLDaG5PwqcZ4jxJDb9Q+hetrtVtR+O423SL6LlPNXrA
        6dQiMY+2vIeApQiEbZDgvs5Umf/lEHuPN/ylJT4RP8v6N5LsXRMgCqOqW0XBIPphLzawxPq5G26
        6hYLI4LuOemwrBv5rihNF
X-Received: by 2002:a17:906:2c52:b0:872:b17a:9b59 with SMTP id f18-20020a1709062c5200b00872b17a9b59mr16386162ejh.38.1677083386341;
        Wed, 22 Feb 2023 08:29:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9mKhxNU0toPrOpizencRsf7u9Zdn0iobHQyM0QkbBRRqDQ1cnKeP9NI+xCgpywhsqBjfwodg==
X-Received: by 2002:a17:906:2c52:b0:872:b17a:9b59 with SMTP id f18-20020a1709062c5200b00872b17a9b59mr16386142ejh.38.1677083386055;
        Wed, 22 Feb 2023 08:29:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gw20-20020a170906f15400b008ea5f4fab5fsm352187ejb.145.2023.02.22.08.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:29:45 -0800 (PST)
Message-ID: <1761ee67-5912-56d1-5e27-28135b3c0620@redhat.com>
Date:   Wed, 22 Feb 2023 17:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] iio: light: cm32181: Unregister second I2C client if
 present
Content-Language: en-US, nl
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     Kevin Tsai <ktsai@capellamicro.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230222162408.1996023-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230222162408.1996023-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/22/23 17:24, Kai-Heng Feng wrote:
> If a second dummy client that talks to the actual I2C address was
> created in probe(), there should be a proper cleanup on driver and
> device removal to avoid leakage.
> 
> So unregister the dummy client via another callback.
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Fixes: c1e62062ff54 ("iio: light: cm32181: Handle CM3218 ACPI devices with 2 I2C resources")
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2152281
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
>  - Use devm_add_action_or_reset() in a correct place.
>  - Wording.
> 
> v2:
>  - Use devm_add_action_or_reset() instead of remove() callback to avoid
>    race.
> 
>  drivers/iio/light/cm32181.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b1674a5bfa368..b3da7a517aaea 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -429,6 +429,14 @@ static const struct iio_info cm32181_info = {
>  	.attrs			= &cm32181_attribute_group,
>  };
>  
> +static void cm32181_unregister_dummy_client(void *data)
> +{
> +	struct i2c_client *client = data;
> +
> +	/* Unregister the dummy client */
> +	i2c_unregister_device(client);
> +}
> +
>  static int cm32181_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -460,6 +468,12 @@ static int cm32181_probe(struct i2c_client *client)
>  		client = i2c_acpi_new_device(dev, 1, &board_info);
>  		if (IS_ERR(client))
>  			return PTR_ERR(client);
> +
> +		ret = devm_add_action_or_reset(dev, cm32181_unregister_dummy_client, client);
> +		if (ret) {
> +			dev_err(dev, "%s: add devres action failed\n", __func__);
> +			return ret;
> +		}

Sorry to be a bit pedantic here, but the only way devm_add_action_or_reset() can fail is
if kmalloc fails and we generally do not log errors for kmalloc failures (because the MM
layer will already complain loudly).

So this can be simplified to just:

		ret = devm_add_action_or_reset(dev, cm32181_unregister_dummy_client, client);
		if (ret)
			return ret;

Can you do a v4 with this changed please ?  With this fixed feel free to add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to v4.

Regards,

Hans


