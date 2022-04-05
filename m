Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D684F45FC
	for <lists+linux-iio@lfdr.de>; Wed,  6 Apr 2022 00:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiDEOJ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Apr 2022 10:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358098AbiDEMKc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2022 08:10:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319938F98F
        for <linux-iio@vger.kernel.org>; Tue,  5 Apr 2022 04:22:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ot30so16048049ejb.12
        for <linux-iio@vger.kernel.org>; Tue, 05 Apr 2022 04:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3n64ZO6Zi2LKzrWKKoARN+uqERGYLr1xbe1J9am2lEg=;
        b=ihTiCa7wj1hV3pmq40yuVqleQPfTOhQcOnzBW/X3xqPufmWtXOElWJgVjVjj4dSnMT
         DSR5lJrc1mqE7WeYjzbFtOyWXtBG13GxrJeztUTLrxQWKBb9yVpn/lSgmq6cv8M+mu6i
         aJBLklF5PI4IrypJs5KANZdMN/tvPOWBYzj1h3I6P51299uDdZMP4TgxZwhIZ9LCLw9d
         4fkEnJjhXSmTvpKl+zWhcXBQza5bkBM+rc/qo9CC+zILfT1Z2A8SWo1sKPjO01SWWz5Z
         E0ufQGJW4mqkAf5TR2bxr/bA7hmWTZtDk8a4E9dAIDhoaiYkJ6U/KK7KY7HIN4oZJS65
         hYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3n64ZO6Zi2LKzrWKKoARN+uqERGYLr1xbe1J9am2lEg=;
        b=e1AK0n8qVQCcCVW9mL3JOUc8hdMEiPaP3wP8/jPRajYwjb/Q/aWPYsvEbHc66QHajA
         0fxSfOL087+fVU59EFbP7TaqNvS2vxLP/Ig9S2is1VBJ54ouOxGnDdk1RwCO68h2sUPG
         bo+intl6Cull9MxmyehGo0Y4V9eXQwH1r5vU89OZWpLTStyApztg4jgsqzllD/+N6RfT
         RhAbE7xv2XWneQiM+2/3X5d8BsWUEOz3QYfCi31RP2x6XjJL1M0v1Hge8SEKLfrHEnIA
         FF6To+//rSSOOn6p6IR9NCHIdrIlon1qTMmt8NCmtQy2nsvnCHTtJqbVJHtcxJYHg7Il
         1ymA==
X-Gm-Message-State: AOAM531zSGuXLlVcBT771JuXebPHSPBwYugCaqUiNWSJmWLsy9bilSJD
        qFqsWKkcDjyK9DJZ1/6waFUyFw==
X-Google-Smtp-Source: ABdhPJzbAzUWiQ2rSATW807UfIMBntbyM9kwwaxJtsRgY2UiyPXJpPD1r7VRIosw1z9ls4bXKBkx4A==
X-Received: by 2002:a17:906:1b46:b0:6e8:4cc:b381 with SMTP id p6-20020a1709061b4600b006e804ccb381mr2982724ejg.563.1649157759830;
        Tue, 05 Apr 2022 04:22:39 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm6478339edd.48.2022.04.05.04.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 04:22:39 -0700 (PDT)
Message-ID: <d27af04d-0a18-fc0a-b5b8-91e65e2d65aa@linaro.org>
Date:   Tue, 5 Apr 2022 13:22:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx
 device bindings
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
References: <cover.1649100168.git.lorenzo@kernel.org>
 <2e5304b7e11085d4e701b4b591fd79cc54f01301.1649100168.git.lorenzo@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2e5304b7e11085d4e701b4b591fd79cc54f01301.1649100168.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 04/04/2022 21:24, Lorenzo Bianconi wrote:
> Add device bindings for asm330lhhx IMU sensor.
> Use lsm6dsr as fallback device for asm330lhhx since it implements all
> the features currently supported by asm330lhhx.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  .../bindings/iio/imu/st,lsm6dsx.yaml          | 38 ++++++++++---------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
