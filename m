Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC72A231B56
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 10:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgG2Ii6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2Ii6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2020 04:38:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CD0C0619D4
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:38:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p1so11499165pls.4
        for <linux-iio@vger.kernel.org>; Wed, 29 Jul 2020 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=HbtJE63+eO8A7hJIYpadhjS7rkPV5HGagSVTfU+DbFQ=;
        b=W/NNhbO1UHWwgBubTrG+vvCvJWc3ROwi3sun459A2CESXYwYFM9TussMxojmXwp6RP
         BddeN0djhDJlRYMsXk1FpzwXIOSFQCST/Jxp3NfHEmSuliDqGq+RO62ZgCjv/I4kZDTy
         LiJV6QOGKrhLhxhlJCSEdzatM2lEg2G4SJ0fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=HbtJE63+eO8A7hJIYpadhjS7rkPV5HGagSVTfU+DbFQ=;
        b=Uptb7yVaIad8X6eBh86epa6yZF2Zc+u7uejTKLlC46C9Fga+fl2yA6G+ly7cWRxYD6
         /c+1wLfs1JsXRZEPkFlZN/zVy5q4V8/BjwTLPkSU/GWLBL/KMaQPDHRDnLgAQXd3jCMe
         MB3tQ+4OmC4zGBpwmWYtqXPb134Xgsr6g1AYLFLckvjZdqd1zRATvmdrh62j5eEgdPI+
         yYoiwC+jWLIGuWh/LyjpltMSs7KdQ5Gpqe6TAIy7i8gQVu+AEAE2L3q9dKx6npiSZrGw
         ordyYAxIUtc3zkrM0ueWfIUtq91VRBSfHM7rfCSFvfozEgXhr3/EwQTSOPZQ/YRhaOXQ
         OM/w==
X-Gm-Message-State: AOAM530Ym14cElBR7ntH+Wz+G6qQrqq3lS4JQQG1vDhI6DkEj0CBOvbz
        1wQNZayjF6Nxm5KVdoV7vcLSwg==
X-Google-Smtp-Source: ABdhPJydymo0wEUaSrTPX7MFw0FkDuVjogsdoOwK7zJwZa3jI6qPQwQePOSbT+8zQ7E9z43dmd+qvg==
X-Received: by 2002:a17:90a:1f81:: with SMTP id x1mr7911944pja.115.1596011935538;
        Wed, 29 Jul 2020 01:38:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c9sm1394247pjr.35.2020.07.29.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:38:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728170317.v2.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
Subject: Re: [PATCH v2 04/14] iio: sx9310: Remove acpi and of table macros
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jul 2020 01:38:52 -0700
Message-ID: <159601193272.1360974.2787015814101675037@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:10)
> Avoids unused warnings due to acpi/of table macros.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
