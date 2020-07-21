Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB715227D21
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 12:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGUKec (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 06:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgGUKec (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 06:34:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14532C061794;
        Tue, 21 Jul 2020 03:34:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so1371630pjb.2;
        Tue, 21 Jul 2020 03:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xpNqgo9hQYt3ZfAIXEIbhTS1NiI/kJWqbxd0n8nA5c=;
        b=orSO6WjLA5L+bTIPtqo3LKTrX+6FYOi8TQ4GN1s9ZQlP93OO4O3RyApn510BAuxmn/
         q0I7mXQJhbcXqzdAL3S4Zx7SaH4SAosVf32lNCv5TiOeO36CvevXbCzpTCJ6ohFpAfKF
         2tqJPNkLkKg+H7KDMXiqE+C/PDruX3d4cHMtETyPwOAFBJlEXAYMx8QJi8p5noWBQ1Ba
         Em5r3KvGeVldSYlb8A0NTDLS3SEe5PxEG+zb1FF1cNTbi/AZZC2DMSc+4QNKvH1geIt7
         Ezw55DManz0OuOTNLKaelDtGeafJVvgXesyvRUkYQekivp0A/7Is1LrUFlWB8YjNFhtv
         xqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xpNqgo9hQYt3ZfAIXEIbhTS1NiI/kJWqbxd0n8nA5c=;
        b=H4iO2uvCKQw9wT06+AMNj54/WWDdZZOM/HiO1ur178tTxCDW8Y+OwDbUwDFO7pONPu
         Ds4teUsnPOdCd05gDrLWLGoSpBgKxEFHZlk0sIQ5tikX6FHf74EkhyhBNoW4JFhlK9Ed
         R4TKw0t85lwmNgw4xb4j7cgl9PiTRShuVGKKFX9vFLZnfW9X5Xx8OpsNgXviIgNG5N3x
         uOTaj29FFFGaYtKWp7W/hr1HWnpcrekSPDkfqCDQ/fTX69FTuQA2qR+PiDcsozCBnQRz
         fP1+qIDFUte3AEmRTFPsbA6+7iwZH9tFO8NDCOgPcsHt8BMBxuhQhv1SEViJJLCJ8rTd
         KVzQ==
X-Gm-Message-State: AOAM530k5m/1N/mwDZ5gT4WClYTQkTgBUz3AvRMvm/OjQGSrULHMm3un
        XYjCohbzq1hJ11d5urqpl9cFevCYg5GYKnvewP2PxpWTraA=
X-Google-Smtp-Source: ABdhPJwErUkg5EBb65hVFaIiiEun4OispTsBR3u3dGtfxP8niju8Shiz6byJP+5FfRnBaN6HxHtzl/nFHZ75GkBRhyw=
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr94186pjb.145.1595327671428;
 Tue, 21 Jul 2020 03:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200721102407.134402-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200721102407.134402-1-alexandru.ardelean@analog.com>
From:   Dmitry Baryshkov <dbaryshkov@gmail.com>
Date:   Tue, 21 Jul 2020 13:34:19 +0300
Message-ID: <CALT56yO842Kt56Dtsd-+YE04-HbH7cQnEQpn6dp+7YhYJ=-hYQ@mail.gmail.com>
Subject: Re: [PATCH] iio: core: fix/re-introduce back parent assignment
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

=D0=B2=D1=82, 21 =D0=B8=D1=8E=D0=BB. 2020 =D0=B3. =D0=B2 13:24, Alexandru A=
rdelean <alexandru.ardelean@analog.com>:
>
> This was introduced initially via commit 78289b4a58b58 ("iio: core: pass
> parent device as parameter during allocation"), but was accidentally
> removed via commit 6d4ebd565d15f ("iio: core: wrap IIO device into an
> iio_dev_opaque object").
>
> This looks like a rebase gone wrong, and ends up breaking devicetree
> bindings of IIO clients.
>
> This change adds back the parent assignment.
>
> Fixes 6d4ebd565d15f: ("iio: core: wrap IIO device into an iio_dev_opaque =
object")
> Reported-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Tested-by: Dmitry Baryshkov <dbaryshkov@gmail.com>

--=20
With best wishes
Dmitry
