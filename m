Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECCB2D4549
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgLIPWy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgLIPWq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:22:46 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA7C061793
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 07:22:06 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id r4so1084522pls.11
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJz7uOhSOe0ysUU/RKOvCL6i2ripuxeMy342xf01EhY=;
        b=CmkbG/SR4ZEJjBwNlILtTglQeK/Y4eRlPm0NLzqVtP60BNOFj/+dn0TTp1EtlonTQI
         gw34JtEZp/fYokCMtONHxN4pCsWWpbruY3saWlo4i+WV3w5GxRcZUPHWGomQwPMuS21t
         6fx/jZNdVsqA1Nzwvex345l33vQqxQein8WOZbxQ3zGUgp4CAzfQJbTui6cjrw0blKs5
         ZAQjPxmPreH21t5JKdEiUXBgUzfquqKiUjLgiZQcgYV7V3F+RrpIIEtc5egAjm7uLU46
         pHw489sr4MrPsXE4xBbRTvLUWTe+FOR7vbGNNiew9XM/KyFlj45rMD2RVFHuBEyDBiDf
         omfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJz7uOhSOe0ysUU/RKOvCL6i2ripuxeMy342xf01EhY=;
        b=Bj7ygdysKlHMxqR1TW4XXAjzJqCiLyZ1XWde4VWwQ5FCxAS3NGeDGnA9jSKmQx2ZGT
         yCiNEyR9H4dBIJ0Hxd5+LVsBuRD6F9veApvtbQcMzaSsIZXGlzE7gX0C3tT1bojggv1d
         +W+EZ54pXyhgu2gO1wV2L2q9mZR2D5SgwV0cvUCY6oZquPNzkyWG06aBO6cmK2+0pZTW
         LW60om05Mdi+KMST6zBs5Jck7pMp855TzqG4YBTS1FNHKi6Sy4bPGmxr7bMpQlMSAehg
         al0mp+t1rDLTNjjjTI50Ftz1qt2PpKlfBJ5mXJo/bmA/nFOMJ9+3Snq41wZF9eTlwkEq
         ZC8w==
X-Gm-Message-State: AOAM530NWbjwAISTqRw4wMNdYBQ+xDDsOElLlbVrm1PK/oJijGaGfalr
        YHCZWmnP2Oup7/fHP03JuEFGnjXD+h1Xy41tC8c=
X-Google-Smtp-Source: ABdhPJwlPVIRNwNcOw6Ue1r+fIECBmJ63si6W++WeAOkt9z92h2bAp81l0R93Hw40JnB9OHK1iQyBmkLuBR48GXcWJo=
X-Received: by 2002:a17:902:c244:b029:da:e63c:cede with SMTP id
 4-20020a170902c244b02900dae63ccedemr2426761plg.0.1607527326258; Wed, 09 Dec
 2020 07:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20201204194803.751866-1-gwendal@chromium.org> <20201205180631.004173e5@archlinux>
In-Reply-To: <20201205180631.004173e5@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 17:22:54 +0200
Message-ID: <CAHp75VeYgBN8GJXs5bTJpML9Q=jZHJkh7h877Of5-Jn2E3Z_yg@mail.gmail.com>
Subject: Re: [PATCH] iio: hrtimer: Allow sub Hz granularity
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 5, 2020 at 8:45 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri,  4 Dec 2020 11:48:03 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:

> Looks good to me. I'd like this one to sit on the list a little longer though
> + it's missed this cycle anyway so we have plenty of time!

The patch has a big issue, i.e. documentation update... where?

-- 
With Best Regards,
Andy Shevchenko
