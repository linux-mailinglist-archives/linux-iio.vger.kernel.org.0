Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8D22D32F
	for <lists+linux-iio@lfdr.de>; Sat, 25 Jul 2020 02:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgGYARl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 20:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYARk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 20:17:40 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08418C0619E4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:17:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d18so8164835edv.6
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+Khyx7k9UOvsWviHkgBl07QUgeTKR6vK8nRDrh7xTU=;
        b=adUoi3lyM0wk7wJv1lUjSJ5JUtOA11ausxEEkI1YK/ueraqEIdmpoMmo62pZpBrtbj
         55VP3Xe6fjSNc/bMBhA8gey0pISp6LZC3TS4BrOtO8ExLGvUuAgybg3g1T/VpVrpzpoD
         U0P1WS35S/zYd+Ju56PXVOXNlb83a52fdVD/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+Khyx7k9UOvsWviHkgBl07QUgeTKR6vK8nRDrh7xTU=;
        b=nTRYwjy+4rhuc4Oz9+MGwQql5IJZgjEtLKonWm8cLGRa+PHUI4AFifPNm+jmFUClR6
         1b0iXyOAzspgqfZ0qLi7xpiVm9Yv4VzFNLj/iqHU0FBL3r9btPmCN1K+S7ELFVMWIZLT
         6/Zskh0rDWjBLyE4aWsbBRN+bKrk5gBPVTBvw0BaUGqbHo17VDX9ali6p5ambROQT+RX
         cobAVE/HAJ6DmT+EIZvBW5tYdt53M116m0XsrRPIODZUpD9Vmj8Um+Klzen41F3/uE4u
         DrteLdL+hXrmSijDn+H6EyltJuX9dQtufeCUt26Ne8gldm61x5/0T1wK1Jj53g9F0GrJ
         t/4Q==
X-Gm-Message-State: AOAM533U//ORURruLXZ0Ys8BiifFbpmY+zbiOZIwZ29Maz/Ea+VzvLYJ
        gQtKY+n6YRqzag8zUltSQfwdQZHRNYw=
X-Google-Smtp-Source: ABdhPJwC1T+1UGfpbpTxKbFg6RW1vvV1z/oHPVA5n3VZmS9iEDNButmo2MNa2cHTxgO+OUwaG7h+Mw==
X-Received: by 2002:a50:c355:: with SMTP id q21mr11392370edb.121.1595636257329;
        Fri, 24 Jul 2020 17:17:37 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id q25sm1704503edb.58.2020.07.24.17.17.36
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 17:17:36 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id t142so3258394wmt.4
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 17:17:36 -0700 (PDT)
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr10508784wmf.103.1595636256044;
 Fri, 24 Jul 2020 17:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213329.899216-1-swboyd@chromium.org> <20200724213329.899216-5-swboyd@chromium.org>
In-Reply-To: <20200724213329.899216-5-swboyd@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Fri, 24 Jul 2020 18:17:00 -0600
X-Gmail-Original-Message-ID: <CAHcu+VbPbpqzc1xVqWZ9Uq0NRigpNDiNbkWupedOpOXVO6SN3Q@mail.gmail.com>
Message-ID: <CAHcu+VbPbpqzc1xVqWZ9Uq0NRigpNDiNbkWupedOpOXVO6SN3Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iio: sx9310: Drop channel_users[]
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jul 24, 2020 at 3:33 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This struct member isn't used. Drop it.
>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Campello <campello@chromium.org>
