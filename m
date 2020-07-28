Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97E2312BB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732821AbgG1TcI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732819AbgG1TcH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:32:07 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE3C0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:32:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so3636284pfl.11
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=kMhjJ3hvBgwbKsHhi3fqlBSIcNca41e66swSh7pO1VQ=;
        b=lH4opCzKcnaxkoNblG1ud2QZbtBFLhw2H3rp5dDPbiW3HhSPtCkBbyCHXIbINNXpxP
         UAyojB0odJhtwfhIB2tej5Wk3vnVMjUCsvDj6ltv/ot3+DN06yuN8vjzaiHPzYhCrhS3
         pkCOpuBQ2Ud2WwjRbvNxw+zE1ouOO4fW+DxY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=kMhjJ3hvBgwbKsHhi3fqlBSIcNca41e66swSh7pO1VQ=;
        b=h/JMNoLrVxtTa1Ym+01wfkwyTV+ZXHImq+O+Em6Syy2rNqO2txjYzWK1Fy33ZU1J5c
         XwHr6ijTXxCaJ8MLUbs1RjaXRME44vZIh4KQy9DQ6WQvedKAT3kRQaw1rQmzlrIhJCL8
         RbMBTNljKd7RAddzpFoBKsyxV7sv43oC6Qe6xmSBFn2SAQ3CME7Q2AvQgXtdsPYXatgp
         AOtmzLds0r1D9lYF+BALoR9dJqAcoyUUW8Ivy/bjTxG0BS5ew5weidkqIPXMsmI14Krx
         Z6HDVzau3JWjApEakUSNvlz6NxzhDynC3J3mmvXRdDg3gYOoUFCgC20zcbQc+HWgoxvY
         dHbg==
X-Gm-Message-State: AOAM531MsSRhRPtrgUA0VHzCUqnSnTGSAZlcb2oe/9+iiQoqrq009mYV
        GG92WAXPqz/81BV2SrMDg/KC1A==
X-Google-Smtp-Source: ABdhPJwf4+mQndf+Efryc8XYmv3htvQaK+VS/A7pthKtDJT/NG+gtXYtnhykek9ejf8PLjN7bw9d4g==
X-Received: by 2002:aa7:9186:: with SMTP id x6mr26598292pfa.103.1595964726370;
        Tue, 28 Jul 2020 12:32:06 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id w3sm19358687pff.56.2020.07.28.12.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:32:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.5.I0ea31fe183b99838b28213df05b0e7912db3ba29@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.5.I0ea31fe183b99838b28213df05b0e7912db3ba29@changeid>
Subject: Re: [PATCH 05/15] iio: sx9310: Change from .probe to .probe_new
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:32:04 -0700
Message-ID: <159596472439.1360974.16024041965670839787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:48)
> Uses .probe_new in place of .probe. Also uses device_get_match_data()
> for whoami matching.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
