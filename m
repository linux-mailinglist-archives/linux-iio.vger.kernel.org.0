Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972676E7929
	for <lists+linux-iio@lfdr.de>; Wed, 19 Apr 2023 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjDSL7z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Apr 2023 07:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjDSL7m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Apr 2023 07:59:42 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8715634
        for <linux-iio@vger.kernel.org>; Wed, 19 Apr 2023 04:59:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51fdc1a1270so986039a12.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Apr 2023 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax-com.20221208.gappssmtp.com; s=20221208; t=1681905554; x=1684497554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUvUuZW0hb6ySO1D/CZR6cQdKPmeYm03b/JvxU+1OE4=;
        b=smVA1jpjlCoNuV/kCvvonS2vqw5oIKotZhUXv7kcXkv2W7crDfQ8UaCgenMKRsuF14
         qgjA3OtwE9QCmRNPsWZzHl79HItHnflKZMkOy+oBBHRAYJ3XjuLGKVfIHcEK/i53WzGz
         D4rBcoILeMKTQoGGIRpRDnjnAD1UQJbDr0NM1xKWEwvc6tjD2DpVHUzDRQOAXl9p24Ve
         JR3eFI5UVPac8+iOgkvBdVf3cR9mvBF/zWFIK7E8cT1ObKzvYO4E0pnXdpA/heuCwJhW
         gz8g219o+iGiB0OtLGpwu6H01VPIi4JZj70KJiVKhrnudrGiyDy61AQ6xEdnb3d072c5
         CW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905554; x=1684497554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUvUuZW0hb6ySO1D/CZR6cQdKPmeYm03b/JvxU+1OE4=;
        b=Q/l49cAXSZMAzR3SHxAUxt0wuUpAmdWV8oUJ/XRh+ruWDhjbn3MLwarhMRUXtscbpG
         SfxJUoRByZvsqr6Xvj+dpAQY2h9fhEBuj9etsf7QS3RTAg1IePAUNO4riwz3bcET6w09
         xCVENflc9RFxL9DbQ28lMUCqPx+jEQ+AQXzEbqKmUvBZD01mFtAFp25ZF9GvpjaqgjTP
         R3maQD7z9GSZn9mBAdxmpkB4bTO9hIZqFQMntwc1EAOgwId8XEzgAQjsJCC4TJk8PKqI
         awwqk1AZhveLdr5Tmc9Rggy3Ltl7/KCMs8yScL1M95IGlUrljh4pEIBAF9gYc2uielI/
         d9+g==
X-Gm-Message-State: AAQBX9eN9SdBaUvw5LtCPHKKRR6oAhr2F6o3oEDEMKAOJ2384P7q0gaY
        Vh5Qrq6xTZHitfcT6bxYcgPk61de+Tw9O8UBGzDgIQ==
X-Google-Smtp-Source: AKy350bS9zSZGBFjAnnKlFvzeAs9kADltOy8m4ogWbI6TfmOViZ52LJEPr/IJUbufZUeyyEz6cYxmQV4IaXPqsHMtEI=
X-Received: by 2002:a17:90b:4a06:b0:246:ac68:297 with SMTP id
 kk6-20020a17090b4a0600b00246ac680297mr2818013pjb.0.1681905554420; Wed, 19 Apr
 2023 04:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230414102744.150-1-honda@mechatrax.com> <5c8f68f0157d9ae66e6d88d648fcfd26e68be307.camel@gmail.com>
In-Reply-To: <5c8f68f0157d9ae66e6d88d648fcfd26e68be307.camel@gmail.com>
From:   Masahiro Honda <honda@mechatrax.com>
Date:   Wed, 19 Apr 2023 20:58:37 +0900
Message-ID: <CA+Tz-SHS28N_nABk0F=rhdg8tvzPFC=+RiOrC6X7n+51LBJs6Q@mail.gmail.com>
Subject: Re: [PATCH v2] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Nuno,

Thank you for your advice.

On Tue, Apr 18, 2023 at 8:06=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
> I'm not really keen with having the Kconfig option. I'm fairly convinced =
that
> this might be a problem affecting all sigma delta ADCs and even if they a=
ren't
> affected, I do not think that setting this IRQ flag will do any arm (othe=
r than
> less efficiency maybe).
>
>
> If you really want to be on the safe side, we could add a new boolean to =
'struct
> ad_sigma_delta_info' that would be enabled for your device and when true,=
 the
> LAZY bit is set. Once we prove that all devices might be affected by this=
 issue,
> we could remove the boolean and make it a default setting.
>
> - Nuno S=C3=A1

I understand. I'll only set and clear the IRQ flag.
