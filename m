Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A34E7C56
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiCZAHG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 20:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiCZAGw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 20:06:52 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC251C5526
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:05:17 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k18-20020a9d7012000000b005cdb11186f2so5364241otj.9
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=qjeDSMxPHLhwhm9GfWiU1CRORUcVuYIFjOuSPrwZ6GI=;
        b=Bga6tcRLkL+e4HV1/Dl0fJEww+TcBYQP6EMfTNzT46ZPkVjU876OSFxHzt5QqP/vj8
         jD9CN+v7u5+I9EFrt9e9mpxaEnOf2TUaPY1ZygZ/VI5yUByKElysjrVbQR2TLp21ZKVg
         vMMCrYkzdwlmgAzuQBrq78s1K6IC4YRHSezdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=qjeDSMxPHLhwhm9GfWiU1CRORUcVuYIFjOuSPrwZ6GI=;
        b=1zFQIyfLtst5ye4N49KQ+N+PXgrXinYH//XgIg3JdHEryJD+tgqexkne4GPLmrk+GE
         ePPFS8BOZnUIDpoxupgdHUerqF/7fRMw36sfPwyyMD0trUcMmR+D6Jq66FJ4zq3d+Tgx
         jgXSZ8POnfnM7LGb/HtfhRAPab4gWL55BOuYQK0S6jBTPCKnV/0+QoSiILyOdRka3Pi8
         i3kNBlhO6xG+Qp1Zt66elAAhXneXFzBd84TKEQgsxKYRgIVMg3PiISR3RiWZtiptfyOn
         bm1wPlMltKipZVYpHKbqIT7cqTR1WWZcBzaL1V8i7LIi4HEvDd+8arVIIv418DOI2O4R
         S+qg==
X-Gm-Message-State: AOAM531/EgZYgxrzJ+segNr1O6e2rIPxqrFNJvML7574hhPB6yfJSzgu
        FZNXnQjnMCceVS7gtyKI57R/jkKzmNSM8SfhP5bDfA==
X-Google-Smtp-Source: ABdhPJwna4v6hnDWtZyUf+3qkEmJHd8+Rv9/vLZRq3hDtnF/a8HX/eIq5hVn0Pdgz6xMqUp6IZOsQo+qyKP+VsMVajk=
X-Received: by 2002:a05:6830:61b:b0:5cc:e44:7dc3 with SMTP id
 w27-20020a056830061b00b005cc0e447dc3mr5552158oti.159.1648253117386; Fri, 25
 Mar 2022 17:05:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 19:05:16 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-9-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-9-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 19:05:16 -0500
Message-ID: <CAE-0n52vsBFTvPzykWAA9uVcbUho3fxTmFFpGNBPumK3HnQvYw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] iio: sx9360: Add pre-charge resistor setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:27)
> Add ability to set the precharge internal resistance from the device
> tree.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
