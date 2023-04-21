Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09EF6EA62A
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjDUIpB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjDUIoW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 04:44:22 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3EEAD12
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:43:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b8f64317611so589356276.0
        for <linux-iio@vger.kernel.org>; Fri, 21 Apr 2023 01:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682066628; x=1684658628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB7OczqlU5GlOy2Zd9Rj3EOn0m2+6oU/DJ3XuT+77QE=;
        b=OXxmlnhFGlBUHNcmd+OkPmbb9r/taSkf+vrVB+i1O0PVlopkmHODWY18HgOWPt6ATq
         xWPpEEQgelEDU0l30b8lhpkE3OVCpcAnji+iG/0dXp7XEOwWg2eXoAnTRWFMuMU260dw
         VtUHwow/hj3KIcM1h+cs2oXVhYoR3o8S7ebPPiIpdSYfetwbwei0ThU653b1OMshM3eB
         Oyo0iqnOvnYwHfzXTKfCOAYGOKV61mq5B+2g9SGqDD9IcMV2i02uEvRwgFiqnlhJutbT
         b3HZpLH6fJ00az+cuhprxokwGl1bFzggbv1Eubn+VWuTyVvPQg0rdt8fZxyyJYCLKJfd
         Ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682066628; x=1684658628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB7OczqlU5GlOy2Zd9Rj3EOn0m2+6oU/DJ3XuT+77QE=;
        b=dK5i1X1nGdkL3ATtDmqZBknhTmSm55CtKv5mtVj2sXvZ1LKY4IOyRdT7dz2OEqjTjF
         1sZ8pidSd5rUaRkKBEilhcVxFqjeb0cOMoxqQbe6XnJpa8TxrGZ/c/vu+as84PZhQvzB
         fLG092DUI2vvZfNo2/FvJQ969TgYIwS91MA4G5YFdj68LsbjThrwiR8J6GWwaM5959WF
         JTYFkzIS0mC9OkXBfkNyRTM4G1/05kgI/dqoEklCeKror59vm22SBdv2zsa8ZaGBxbDH
         Cp0CXMfNJyTrP4jwyo1R8/GmWKTc8YLUsy59oS46+mMQr8pnmwdC75ZK0cykXHsMUzoX
         P0Bw==
X-Gm-Message-State: AAQBX9eR/iyuTxQ5hFdPwv59pmQ+GeKT4uoI4M+QyQmYqKGvzvaxZajW
        MLUgCRO78K1itvg4zKOsF3t5zhV2bQfUJAJmbwXmAA==
X-Google-Smtp-Source: AKy350bpPZ0S/XO6upKWqUoG5fpVD9ioAg/A0YRm/02f/LCUie/ZnJMKTyUgcbE6/nIhxLdF5BrdASq+GnAR1HP9tSk=
X-Received: by 2002:a0d:ea0d:0:b0:552:a2e2:684e with SMTP id
 t13-20020a0dea0d000000b00552a2e2684emr1188907ywe.52.1682066627835; Fri, 21
 Apr 2023 01:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230415231130.115094-1-mail@mariushoch.de> <20230415231130.115094-6-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-6-mail@mariushoch.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Apr 2023 10:43:36 +0200
Message-ID: <CACRpkdbyB8FagXey1-huiirHPasJs47pMGKx9TZ0+X0tC=0R1Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] iio: Comment that the LSM303D also has the
 Magnetometer DRDY
To:     Marius Hoch <mail@mariushoch.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Apr 16, 2023 at 1:12=E2=80=AFAM Marius Hoch <mail@mariushoch.de> wr=
ote:

> Per its datasheet, the LSM303D also features that
> pin.
>
> Signed-off-by: Marius Hoch <mail@mariushoch.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
