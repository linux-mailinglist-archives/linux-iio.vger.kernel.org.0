Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A545A22B6AE
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jul 2020 21:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGWT3f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWT3f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 15:29:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45BC0619E3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 12:29:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so3517024pfk.13
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 12:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=K/x2tOMHGvw/i83L77yt0mj2n5UBoDKQeUt3On2GUd4=;
        b=gjZSD2aVJt8KcTJCKakJp6DrtQOApap9cF9iHFVrvOrrEw0QRXx03CQBbwXQHx54uT
         NFg23hfGx0s1WUwhxJtK9P1CthK49t5QsPzXHaKkzri7vtgwnzKu6+FlAAhT/5ZLeGjg
         l0RG+ahYtiYxkwdvLROyBjK9wk4sTbZuIHRX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=K/x2tOMHGvw/i83L77yt0mj2n5UBoDKQeUt3On2GUd4=;
        b=Y7g1+KTa9b1/a98c4qittb0H9J1byhVTrO9trp/WIcSBpaDbQpPFnql20Wit2CVcvk
         OblzuX8WTP38DeagkbAg5uFBdzDRCR+FBJ4+FcQaB2nICs8ttkzWPcmDNSa05teZ/FJH
         LS7ci+3WLs3bxswyIoMEq/koOMrCL27NSxRNMCi4Mw5iTBvcAXBvNwCmySFBFeG8h9Aa
         7IZWsYAi9IRrXhiiKlibj5q5ezttLfO7seW6GAE9gb4w/QA8lvrebGPjzWi5MdzY88zz
         g8yXQG4+3hBB/IuFFJJua9bllox+x7qheVOtgBhzhzh/UdRKtGM+Mg0VpA7vugid7ofc
         55TQ==
X-Gm-Message-State: AOAM532SVNI5PGF9wJhm3VDwgsx9UGjt3PeP0jh9ekncnnlt6bRLJzgr
        +7GAnlHu4sngdZt4GK34JTuLbw==
X-Google-Smtp-Source: ABdhPJx0H6UfXHELhN9FOg1zfdumImKJnOs6681TwMRzBjmHidxeuFNbFoBWBYY0BxdEqhcGHRVd0A==
X-Received: by 2002:a63:e04c:: with SMTP id n12mr5257110pgj.388.1595532574358;
        Thu, 23 Jul 2020 12:29:34 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b4sm3181271pjn.38.2020.07.23.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 12:29:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200414143536.v10.1.I30e2a8ff8cc4ad1ffb65df09ad933e5b4d9f16f8@changeid>
References: <20200414143536.v10.1.I30e2a8ff8cc4ad1ffb65df09ad933e5b4d9f16f8@changeid>
Subject: Re: [PATCH v10 1/2] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Jul 2020 12:29:33 -0700
Message-ID: <159553257307.3847286.4297914412173341085@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-04-14 13:36:07)
> Adds device tree bandings for sx9310 sensor.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

I don't see this picked up anywhere in linux-next. Can we squash in this
change? Typically the voltage regulator names match the data sheet, and
in this case the datasheet names them vdd and svdd. Also, they're not
strictly necessary to be in the binding if they're always on supplies so
we can remove them from the required section and DT files can omit them
if they don't care to actively power manage them.

---8<---
diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310=
.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
index b52ffdac678b..ba734ee868c7 100644
--- a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -31,12 +31,15 @@ properties:
       available or that a close/far proximity event has happened.
     maxItems: 1
=20
-  power-supply: true
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
=20
 required:
   - compatible
   - reg
-  - power-supply
=20
 additionalProperties: false
=20
@@ -51,6 +54,7 @@ examples:
         reg =3D <0x28>;
         interrupt-parent =3D <&pio>;
         interrupts =3D <5 IRQ_TYPE_LEVEL_LOW 5>;
-        power-supply =3D <...>;
+        vdd-supply =3D <&pp3300_a>;
+        svdd-supply =3D <&pp1800_prox>;
       };
     };
