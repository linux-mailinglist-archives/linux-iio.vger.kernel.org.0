Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691FC4A0080
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jan 2022 19:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350731AbiA1SzY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Jan 2022 13:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350726AbiA1SzX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Jan 2022 13:55:23 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1E4C061747
        for <linux-iio@vger.kernel.org>; Fri, 28 Jan 2022 10:55:23 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id hu2so6690027qvb.8
        for <linux-iio@vger.kernel.org>; Fri, 28 Jan 2022 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=DkhOJxPGb96XhBNxvczEuJ4p+whH3mGtofLewGhWrCU=;
        b=nN1TFc2BIbi+Qkqm/pkhdKRTgACS+iVJJscvLZT6YT2rs9dPFrpJrlw8L1IQlHaYEU
         gB+NUKYlmTuyPaekxHgtjegAJQkz6ycdlcNSVfb2OSMEMwYXgKmPTP9Q9KTOaGjWgNEP
         Hgm0sNc1u5457K4JgsFyrFIWQuXoSi+0zktNG1PgTmwR5e0pUvqi5Jaa3cG/Wf8Rbc1U
         +2ekwUGX49Orv+dVO8srlmEWQ+ulOk/s8wPZ30sthAYV5UNqDPP/EtUw65niZJRM+Fuw
         FW11j4ASLPOEC8pbY2HrJ7dwv1oZr4aEW5EUrsDYjSfl/CK2YJIN5e9zT4RsbEmdt0F6
         zkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=DkhOJxPGb96XhBNxvczEuJ4p+whH3mGtofLewGhWrCU=;
        b=jW1TEB42wRC8ElTQo7yJ2CxGjNgyi1ntN5eRBA/rCBTU2aoDyjSrJm/4rI12IUjB/Z
         xhwTb/PGDFEdq2JXmzlmupZn8ftnxMAoBnr9gTvdNK9R/SN0C3FXY+lYWG8zl3Wsp6mK
         0XhStfSi9bT/ItmqmKjVH6lxP2NuU4IGpqJUuN+XqVsbxKU3ujKNiU9KzISZDVlTYSvS
         YsaEHtiOte9/HMyVdGPLY2dvPKh5GPsDjjj+2hQXRoLZhAdckm52ICbLqAC4ub2eJ3Rg
         ltAPsrfIViMDi75DuoNmEDP61k8z8eh/P26GpSMFg3j8lWD4bZeP+qi+v0HHjrb0cFye
         OZfg==
X-Gm-Message-State: AOAM531m8laIDlrrTnz35wn0fOi/KmFCQ772rLuoM3o8/ylsXEyOm8oQ
        eOhBPTVJwZP5pn/ZBDexNx5jC4deOukglm2tpWU=
X-Google-Smtp-Source: ABdhPJwAnQx8Ez2ejHeq10OpiJGhPMk48dKszJD7u/uTYHKL4iFecnVDkJpAvoryPp/fxV1p1edHUD7GjnTeo7yj/GM=
X-Received: by 2002:ad4:5c64:: with SMTP id i4mr8941365qvh.62.1643396122248;
 Fri, 28 Jan 2022 10:55:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:2529:0:0:0:0 with HTTP; Fri, 28 Jan 2022 10:55:21
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <ivanroberti284@gmail.com>
Date:   Fri, 28 Jan 2022 10:55:21 -0800
Message-ID: <CAKp8dfoU5_QOis_S=2C4aKWYjvfWPRtPYTZHfcQkERMdWxvo0A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
did you receive my message i send to you?
