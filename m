Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F8A4E7C17
	for <lists+linux-iio@lfdr.de>; Sat, 26 Mar 2022 01:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiCZAGf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Mar 2022 20:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCZAGc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Mar 2022 20:06:32 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B411C5526
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:04:57 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r8so9900262oib.5
        for <linux-iio@vger.kernel.org>; Fri, 25 Mar 2022 17:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=JBdM3L+hz1UBU3mZPkJ057tNeOZ1uEepPYItJGWmLVQ=;
        b=JwoZ+I8ZIewknpFBakMdl3Vd8mP1MO77qWD1BBFNonF729zax3j8ee/FVr4vlI7N+V
         itV8adGLVADDq90950mJQVgXgIxJTiv0Ya+4iTF5Eo74unhIj9sX6nhB0vIYSZEGVEi1
         I2VzRldNdsp4Uoj7TdBlbWuBHY+QlONSJwJp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=JBdM3L+hz1UBU3mZPkJ057tNeOZ1uEepPYItJGWmLVQ=;
        b=IblEehQDKNI0Ulo3ZlM0h/qdhXRIK1i3nd8+Q1Upvo8Pvk0mtSom9R2aHBqzVdGksk
         wpngeDrBd11mhClhXBOm+/9gbNeLN+fwjpm5dve/iIX6bPfnbWqyaXsAo18PCbVSEikc
         MO3E9+A1glh8mdh7l6RDvnvlhyRRhLWlfTpeOROExVBnXasWAm3tuhhe+PILHlRKnP0Y
         Enn+w7kYCkMgaD50Nd6PravaZ+GWSTwr6XeNHfyFdsg34S1pNTdjZFBOgSNIhz2TG5j8
         Zq8SNZXfdxdDlZx/M9f83woKFymf8PLF1K5XiAnCdJ9t4RxNXY5WZ+lkb3mjTYUiaBvC
         KTxg==
X-Gm-Message-State: AOAM532h68o7IShUpWVgN1WB8fT+DMCBoCKUKxWtvkXxbt/EMZAURunX
        T7z+Qz9O9eoA1jx5UisGfc4LvqG2kLtxER0E4PzwwcmZuOA=
X-Google-Smtp-Source: ABdhPJxRoNOqHT6KnYgf/KO0G/qzUqbwN6CVgIStzU/orP5nJUcRE/xXMX8vhdg4TrvJL4nLTUK8XNyJf89okbE3Z1A=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr6466153oie.193.1648253096462; Fri, 25
 Mar 2022 17:04:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Mar 2022 19:04:56 -0500
MIME-Version: 1.0
In-Reply-To: <20220325220827.3719273-8-gwendal@chromium.org>
References: <20220325220827.3719273-1-gwendal@chromium.org> <20220325220827.3719273-8-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Mar 2022 19:04:56 -0500
Message-ID: <CAE-0n52N22HBd+a_wD2hkYrta7y4QFrpeMTULAVHCKhApdAMdg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: sx9360: Add precharge resistor setting
To:     Gwendal Grignou <gwendal@chromium.org>, jic23@kernel.org,
        robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2022-03-25 15:08:26)
> Allow configure the resistance used during precharge.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
