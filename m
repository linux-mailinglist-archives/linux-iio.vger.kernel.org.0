Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41EA2316F4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 02:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgG2Aui (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 20:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgG2Aui (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 20:50:38 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA8C061794
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 17:50:38 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k27so13325229pgm.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=yP3nfVyanCA5dqt/CLixTo47F6orsxBXLYUlEUkelJA=;
        b=dt830+nXvj5ilJbJdyQ1BTwsy9XQ+4iMd9DFoTO9QT4BQ300OFHMOFxrVxHTXZFS6V
         S0mSc2FW4pXw+dWxaEpFS5dR6VFWEMe7lM1G5PSa0U3HjuO0G1rPqSkMHBEldIUN7wB5
         clSdKm70RHABLzyFL1EkdHvMTgFx6LY9vvz7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=yP3nfVyanCA5dqt/CLixTo47F6orsxBXLYUlEUkelJA=;
        b=h8blG4fk/8DDlfQm9FtFgat6AUHdRjDZBkgeeVm0ow0PB809IGf/2X3/g4tPCIn/2l
         UAsJqjqq+BhjSIc20sseSNhebXx6Xrqi9EHdoFMPp5t0hbSkfMU4ZXhxDa9hHSiGtd3e
         a9w45yLOd9wnUS3GkMPYdmkMSyPeH00CwijgDH1oCsaw+Bo+OB3yb0MrmfoTszklrXKc
         te20kWJ1q36Z/RdXx/51ba0Apzfsl23Bmjl4nbhMTO1itKQ5ukiuxRVDCzbvPXmiUYdO
         EyX6soC5GHn8R3F62//SLd23Er1YnFqbvt2YgzhtlvYuOK8MhkvPAABtxaxki4NRZQvr
         OxiA==
X-Gm-Message-State: AOAM533cGi7wrU4pr8sryuFDgMRQBECEH+TKsOGXKrC8LJqrf7wYUj1U
        JkosF42bdB+Thtwf5jIZ/RMfLA==
X-Google-Smtp-Source: ABdhPJyjNWFaLKqd0efnvtrCmn2FXiK4y+ugceLM2g1jBpdq3X2Mqltt9G/Pr9PBDjNqT3gGtF+1Lw==
X-Received: by 2002:a63:308:: with SMTP id 8mr28317182pgd.112.1595983837445;
        Tue, 28 Jul 2020 17:50:37 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id x23sm230701pfi.60.2020.07.28.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:50:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org>
Subject: Re: [PATCH v2 00/14] sx9310 iio driver updates
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 17:50:34 -0700
Message-ID: <159598383474.1360974.2464583320357224145@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:06)
> The first patch resends the DT binding for the driver that was merged in
> v5.8-rc1 with a small change to update for proper regulators. The second
> through the eleventh patch fixes several issues dropped from v8 to v9
> when the initial patch was merged. The twelveth patch fixes a few
> printks that are missing newlines and should be totally non-trivial to
> apply. The thirteenth patch drops channel_users because it's unused. The
> final patch adds support to enable the svdd and vdd supplies so that
> this driver can work on a board where the svdd supply isn't enabled at
> boot and needs to be turned on before this driver starts to communicate
> with the chip.

Can you please send this as not an in-reply-to the previous series? My
inbox has a hard time realizing that this is a new patch series.
