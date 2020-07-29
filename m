Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B885C2316F7
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 02:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgG2AwD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 20:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbgG2AwC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 20:52:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9088BC0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 17:52:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ha11so1160734pjb.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 17:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=QDhTYDygqkx2ntO2vI3Axdh1bIOd/5JCuYmPgDBl4yk=;
        b=MMe+jKlnCKMx2FZO2VsiHo6y4GEpAHlUeDHRMx1F/oUmucRd/y+r9xzP9h6Vq0eamu
         CfSVX2GRjk4mf64O4JVyRwznmz/0c9k2ZakIFljBpRsL8/GbIsBi+5Loow1P05U4PVec
         /Fmf8SjsfMUpx8mwOZiiu9Pffhfyw+V0rF6v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=QDhTYDygqkx2ntO2vI3Axdh1bIOd/5JCuYmPgDBl4yk=;
        b=NfGx2Kr3vWNz8VhwhDqNkmTlqKMAF3nxB67hynvJW/HZDlmRbVujfR1EnY143mwr1k
         hCvL4Wvgse39M0EUpiLmW6aq6rERewib7AdxAvoKHBxem+Dmc54xIeINcI90pgTaX1FP
         Uj4MY5nDXiiBeBoBQ69MIZpUR8Ac/fZR9PBuKByO9plyBgQ36BIL+gzR4fCm+hmdvWM5
         CaFC6b1wWU6VMa8TkJVzXHvyShD6DYaV8pLwjaSkBmJZEjErgK6ngRzliCEnvkivXNgv
         CAqwKM0G4rDAypguHGkVivHB11mkA4HCUiiWXM8V4sc5U1lRDgmjiezIItK5kNPXV6Vt
         j9eA==
X-Gm-Message-State: AOAM532ynHNe2FSGmdfJmUzCPEejFyUtL65ZQ0e/fuyTVDzSgRZjil/w
        ZUN0wm1KnUyIbzKxHtXYBfntkA==
X-Google-Smtp-Source: ABdhPJwFIViyzzaw1zwGz4VKn+OZfiPXzZ8B1s7e1/ksJAwnJak+2VeK+SEraxPEVFQ/T7f0GoEf+A==
X-Received: by 2002:a17:90a:8918:: with SMTP id u24mr6547623pjn.7.1595983922147;
        Tue, 28 Jul 2020 17:52:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b12sm222345pga.87.2020.07.28.17.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:52:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728170317.v2.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
Subject: Re: [PATCH v2 01/14] dt-bindings: iio: Add bindings for sx9310 sensor
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 17:52:00 -0700
Message-ID: <159598392022.1360974.10427547361260648765@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:07)
> Adds device tree bandings for sx9310 sensor.

s/bandings/bindings/

Not sure why I didn't notice this before.

>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> [swboyd@chromium.org: Add both regulators and make them optional]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>=20
> Changes in v2:
>  - Added #io-channel-cells as a required property

Thanks!
