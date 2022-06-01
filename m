Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D3539E4D
	for <lists+linux-iio@lfdr.de>; Wed,  1 Jun 2022 09:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbiFAHgD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Jun 2022 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbiFAHgA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jun 2022 03:36:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307058CCC8
        for <linux-iio@vger.kernel.org>; Wed,  1 Jun 2022 00:35:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id n28so960980edb.9
        for <linux-iio@vger.kernel.org>; Wed, 01 Jun 2022 00:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TYSMvua2Chy4ew3jbVU8f9W6/MITfKjqjvefw+FJfeM=;
        b=nc1h4qmu96bEFYDvTfzmKUX9pDAjB3hcWg/OC4S+sCk7LHLLhu9JHXMOEZHqJ0Uvuo
         +lBFi7hz1SBU8PWQOONP+WohujLkZBTaddDHVw9kFzhwL5HfjrFN+sluVEMXCDWjiQGM
         NuSMxDdYldUID5yJOA/6vnJ5t/OVGkUV7Sb8Q7kIQlVe41QhYuvhLxwuYDmn/Sm7mAZ/
         ByCE+Y1whybcr+F040ZbAUw11x/50k2pVfZigCcisT7jxCY5o3YSUbYztGx7kivO3E9f
         vzh77uFu2YldfbdKeZ6KspEudt4QnDeNnXEStOwr30yElL4eJIX9azl+lEDFd7eAKmj0
         xZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TYSMvua2Chy4ew3jbVU8f9W6/MITfKjqjvefw+FJfeM=;
        b=0NSBccivCCyLKxtxxlkHOLQ9s4caNneqqioMP6zrvamDfDGw/o/461oC5RL6LlV3a1
         x4w6M6nn6i+sE7dAZK3ohUN8HugaL3aiyKo3Dd3RPzn38QQjfA/IwWOMP2TfFH+Xfh61
         q2p33rYcacQP3sSb2yzCTKm4ISJ/vN7caNDKdH9vQjcDp07c7pjXgTZbgrTOGH2RAiFG
         eozcKOStH5QLlFlCBaaOT/fhZEhNL6hVdN9YE2Fy0+/PEdshauvg6qwS3hDEBmt/A7IA
         NoMGtIcL8CSpCcB30IIoTb6L2fuxJ69q5WMoAKdHMgPRiNWYLE1kD37y0pWoFaduqMFa
         ev0w==
X-Gm-Message-State: AOAM5330URQJnL9iW9H/jrfNBHF5PJSCSGe1BwWzn92+UkY3xGIcKxFs
        O+6STiT5aKA55ZrSaajKQmABsA==
X-Google-Smtp-Source: ABdhPJwNhLbz14jAv7K27z89V2NzlDT0rykgRpsBI1i5lKTIDRrGGa174iGN2HxuUfd9lKCcF1gBpQ==
X-Received: by 2002:a05:6402:2211:b0:42d:cb9e:cbf with SMTP id cq17-20020a056402221100b0042dcb9e0cbfmr18371093edb.76.1654068956833;
        Wed, 01 Jun 2022 00:35:56 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c12-20020aa7d60c000000b0042be14040c1sm502925edr.86.2022.06.01.00.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 00:35:56 -0700 (PDT)
Message-ID: <a02dbc8a-7d7d-5939-1c30-bfe8c7480f1c@linaro.org>
Date:   Wed, 1 Jun 2022 09:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND 00/14] Add Mediatek MT6370 PMIC support
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     cy_huang@richtek.com, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220531111900.19422-1-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220531111900.19422-1-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/05/2022 13:18, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Sorry, for the patch dependency, we resend this patch series and we're
> sorry for any inconvenience that we may have caused. 

What is the reason of resend? I just finished reviewing v1, so shall it
is confusing to see a new one...


Best regards,
Krzysztof
