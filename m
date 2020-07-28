Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F02312F0
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgG1Tlw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732929AbgG1Tlw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 15:41:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F740C0619D4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:41:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so4321644pfp.7
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xAePtirog7IdAkYtDEnGYm+mRDcMeWjIOobv7EO/fls=;
        b=QA45me19PRN1AgIAcLPLUA2SmlfniO5PQjw90UuxM7WPdwz/L21Dd5QxYOdb2o9lRm
         FWgB10mj9BiYopMriQGrhFy537beytEtIJV6UReeJZqiMGlrZCZW5xgBeMIJ9wPNDYq+
         fYlfopXPkdJus7HYEgBDJeELtKrObkFjgL8UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xAePtirog7IdAkYtDEnGYm+mRDcMeWjIOobv7EO/fls=;
        b=dXsUWo7HH3bZcBO2s3fLl4Py2s8M1ZdkAzlzQmzCoZhF9ASQ+TftKN2pUQzigQRCAH
         LWB3VhFJnBtFx75f5CGt0YmcUHPmyMk6sLfRtZVi/OgwhjLISGQ36ksPEW/NdFutYYSk
         ArOlKGSicRfoAn1qQaVVMEe713yY8ogBlhSzwI9xGxAyNgAK2TrTAbzToaTkUTxSaf3+
         BfBfpGTWWxaPE8gNm61fTFgnjzlPjI17ucbvRIxdyOo+1pTBenw3gu201Q4pSH62AOAW
         wLATE7UKbkyK+xiWziSo5jteR+4ESNAw9/KkmVvK73TJKfgn8cwzq1l7frSAU9cy3FO6
         HlPQ==
X-Gm-Message-State: AOAM532dMuimJe4tgedIKSxfWaKQ7tJGz0ZihhNZ7r4w7HOsheJNBjMZ
        lxqkVvPaZX4HNI0BJB6bJpz5/w==
X-Google-Smtp-Source: ABdhPJzw51teMkWyg/WSmUU/bmh78ycTkcPSDZmlOnRd5qRngoSAQqxe6niWrK4452ghk+zFg59GqA==
X-Received: by 2002:a65:6644:: with SMTP id z4mr26754018pgv.391.1595965311946;
        Tue, 28 Jul 2020 12:41:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q17sm22182504pfk.0.2020.07.28.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
Subject: Re: [PATCH 12/15] iio: sx9310: Miscellaneous format fixes
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:41:50 -0700
Message-ID: <159596531010.1360974.12485399142709122883@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:55)
> Miscellaneous format fixes throughout the whole file.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
