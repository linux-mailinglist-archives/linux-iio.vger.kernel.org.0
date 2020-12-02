Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D532CC6B6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 20:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgLBTcs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 14:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgLBTcs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 14:32:48 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1AC0613D6
        for <linux-iio@vger.kernel.org>; Wed,  2 Dec 2020 11:32:08 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n10so1547159pgv.8
        for <linux-iio@vger.kernel.org>; Wed, 02 Dec 2020 11:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=rKU1r8T0uk8dv3E1VwzWFISRFZw/fGD6/LPVBByxRY0=;
        b=B6swpN/83XFi0fMJs95mmBe0bROhdL7qGuiD8xf4Boy5ktpwI4kF/A4eCyoyRHbia5
         i6oo/Wf2S0ZeLIin19koZ3lOWDqQ3riNrwuicOC/uq2Z77TeBTpdXPDDHlK3Oa+zU/dc
         AlCKDFz897a68rCLWrWmVDnan0T50SAScjDz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=rKU1r8T0uk8dv3E1VwzWFISRFZw/fGD6/LPVBByxRY0=;
        b=W/7VPJaGypN408Medp95hRemdwKUp7aXoYYdSLYrsca6EG4anfv9GiGDJw/dmfnhU8
         wQUMC0AjWYOHw50zCTpL5GFP0zzeBhwEWLHGRkMFXkoyP2kVkYGJKGKOjfAsf+RExnb4
         yIDWl0h9yZ8023vwpH3TLnxZ+JqRmMZfy2WMlFSL+qkbarsBaTIco2fOv+50O4Fm6KO0
         W/edNUX98sBs/kh7yyhXmiFufWjr6+RdJTEjiF2Ho/IyXswe36sRbhF7m3ywv39u43Cy
         OpamOMOFWBBpJsWy8njLZ4Ws6OFao1mfVB20EfyocjhiQlRJHC1fpCXrSCw4IHFJsZca
         YECw==
X-Gm-Message-State: AOAM531W58ZNeDLbbzO3GSG5tD/DVbGqylHbNbNP2MvClvbKHjbSCNYW
        xIP9CgUB1vlUuNwk0Ch+HVHabA==
X-Google-Smtp-Source: ABdhPJzFr8hAlaPxnGedSJ73ojvvLugMdFEfklpzFWBctrQcgP5ZIeB/AVBIqTQE8IvR8oZfIMnaIA==
X-Received: by 2002:aa7:824d:0:b029:18b:ad77:1a2b with SMTP id e13-20020aa7824d0000b029018bad771a2bmr3920801pfn.25.1606937527906;
        Wed, 02 Dec 2020 11:32:07 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 17sm537457pfh.173.2020.12.02.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:32:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <X8XqwK0z//8sSWJR@mwanda>
References: <X8XqwK0z//8sSWJR@mwanda>
Subject: Re: [PATCH] iio: sx9310: Off by one in sx9310_read_thresh()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Wed, 02 Dec 2020 11:32:05 -0800
Message-ID: <160693752506.2717324.7949030069848316774@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Dan Carpenter (2020-11-30 23:03:28)
> This > should be >=3D to prevent reading one element beyond the end of
> the sx9310_pthresh_codes[] array.
>=20
> Fixes: ad2b473e2ba3 ("iio: sx9310: Support setting proximity thresholds")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks!

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
