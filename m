Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE09A6F997C
	for <lists+linux-iio@lfdr.de>; Sun,  7 May 2023 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjEGPqZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 May 2023 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEGPqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2023 11:46:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8967F13C08
        for <linux-iio@vger.kernel.org>; Sun,  7 May 2023 08:46:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f22908a082so1043680e87.1
        for <linux-iio@vger.kernel.org>; Sun, 07 May 2023 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683474381; x=1686066381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mMFwsP1GokXoco4sLkCwxPmjmgp4XSFXNsi6M35FmU=;
        b=IYkINLBSVEVGugIjcyNMP7aBfhcoUjUGjitpIItA74cMIPi8fojtsw2tMHGDmfTieL
         IWTWDN7nOKD/3DIZ+aEIRsX08rogFIt14T/PgTXaO7rIcRqSl2JL63ja4PmTFUfKSyi1
         wSnf5iGMj+s9iKVzW9oXphBEoBeEyk5DEmP5zEfaNgwtbnBOFOZCg00GDa8bDG3NaoaH
         PNYtPABqTYPkwD4JnIWlPwYa9FzAM0iHDXyCut1/Niwk1XhA5tCFPFC6/YTXR5Pb8YS2
         sAw8mVDZhKmKFOyEW8I2qsR3G2Ua57s3mhAIfmDmLLO5phnkCeAK1I8Xs44LOnWCXiiA
         hbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683474381; x=1686066381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mMFwsP1GokXoco4sLkCwxPmjmgp4XSFXNsi6M35FmU=;
        b=PsXWZASItJe19Y8MSvQwD1+46WRKRPMkSh5pgQMKHnLvzYXKx6XKf7gZJjtNoNa34W
         rUJOKkHHPdVOErHPLSFeSIsT8/A/fQHqsbAiViVhoKxznA1GrZZaXG/1FNbpJ67U+hHw
         DFkujE5La9IKMqDii7W2cF+vG+yxjOPFYo0TYEgmyu3ii9mX820VSrXnbnJo2Td2kGgF
         4ADzKtczUxiGOodCuVFbUMCTI4Pei+BPPp0mouGUx6vje9iLJIRb6ieIcJbKpkCjvdMZ
         hNM10vP++4dQJgZkOIHQ2Rx1II60LZJRbQEuWrmDBBFU4ti31UkP59VaDC0FIrvde8kg
         bE+A==
X-Gm-Message-State: AC+VfDw7wT/1MVoxtrsjC+fGoUqUKEeD9FV3i/x291SmpGbhPosTO19P
        W1J0vgvLLWfpl1GCeiLHCG1lrw==
X-Google-Smtp-Source: ACHHUZ7vuK/HoIkOZmsKcDB3lECKJ/R5wRWeuJVPoopWViuWyaui+5BQ0/4T8ztAifH1r/ukgdscVw==
X-Received: by 2002:a19:ee04:0:b0:4f1:5001:1d9c with SMTP id g4-20020a19ee04000000b004f150011d9cmr1330158lfb.55.1683474380782;
        Sun, 07 May 2023 08:46:20 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c14-20020ac2530e000000b004e83f386878sm1000134lfh.153.2023.05.07.08.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 08:46:20 -0700 (PDT)
Message-ID: <cd1cc7ef-e92f-aa57-a8d9-7ac7f1c7ac78@linaro.org>
Date:   Sun, 7 May 2023 18:46:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 3/5] iio: adc: qcom-spmi-adc5: Fall back to
 datasheet_name instead of fwnode name
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230502-iio-adc-propagate-fw-node-label-v3-0-6be5db6e6b5a@somainline.org>
 <20230502-iio-adc-propagate-fw-node-label-v3-3-6be5db6e6b5a@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230502-iio-adc-propagate-fw-node-label-v3-3-6be5db6e6b5a@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/05/2023 02:17, Marijn Suijten wrote:
> Since the migration to fwnode_get_name in commit 4f47a236a23d ("iio:
> adc: qcom-spmi-adc5: convert to device properties") the resulting
> adc5_channel_prop::channel_name (renamed from datasheet_name in the
> previous patch) - which is propagated into iio_chan_spec::extend_name -
> was containing the DT node name including @xx suffix if a "label"
> property is not present, while adc5_channels::datasheet_name was thus
> far set by the macros but always remained unread.  Put it to use instead
> of using a confusing name containing @xx in sysfs filenames (again, when
> "label" is not set).
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

