Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BB82D4631
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 16:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgLIP6j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgLIP6f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 10:58:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA720C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 07:57:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id f14so1104979pju.4
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 07:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dyDH22oy7qEE/ohdLpAAMYDPiGtQzkqXCEOQ8NF52bY=;
        b=Hdz1weDND1XHyN3qsnjXGi/mY6HmHFvV89lBdsr7B9hio/GpowU3sceyeraLCPmd6t
         0wjCa22xJpEma/JOh1si4BwpubRuf0LwvcgmAif7jPaMSlLQGUKeKRrGHtl4u4na/F2u
         Zf4FBit+E54J6yU6gWEy7GMzWf71G+jdVK4VJrkE5GKAC4+5A4f/ymoIngYQCp0PfXwv
         mOFgc1qld9MMo3dDGLPtT02HSa9Y3TTwe93B1izGSh97dSoS6UKEqGghwqaBP2Yyr0qu
         GK22Mej4/1z3mQNV5y+JdBtK+TJ+gWCMdApt83QjVQHR6DRON1zbli9kf4S1ODufWN8d
         iJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dyDH22oy7qEE/ohdLpAAMYDPiGtQzkqXCEOQ8NF52bY=;
        b=BpNKI2Pny2wcyEJTDpFbbpnfZ6wRnX6xdRKQFZ3hNl4C4D7+T0C2W3ybqghoG3llHG
         LWdE5+dGssofb/Hx0IyNPb1COgdOfKAcBfKneHUWHxFN77hz+sgfjTpUwh5OfrUn+Xas
         /xKbS7ao6eyB6cjC1hAp1fVnbZlQS8+WRu1APJtUPdIzFG3ZLerYKgp1hC2QnYdHOFLr
         cDLM19E9ZD1cSdOfIGZmhnUzj3LW/oLbZ8+DsPkP3hyal/v6WAZ13Gr1oyAUCIrplJBr
         OAbU6wjrK/5AUDHm3SHiGqK6KC02cgnesd8ZvKCa/nuZBe5xOK19II54zv/xPZUI1VRX
         MEqA==
X-Gm-Message-State: AOAM530py/svwnrIjUB1NrUqF2U8b3UMUyV3PMJWPDHrHKPFid4ZjX2o
        wfDBwyr7nsUGteYF7vde5DihnUnM7WSRhEs3dsjti3p2xQE=
X-Google-Smtp-Source: ABdhPJwVZHh/xXcTuyHg5YtH2i5p153YNnRAcc6vaAqtNgxUs+KM8GhAOY8ISVeswm+nXiYntHyahEk1YYBSlcTY5fE=
X-Received: by 2002:a17:90b:a17:: with SMTP id gg23mr2858744pjb.129.1607529475083;
 Wed, 09 Dec 2020 07:57:55 -0800 (PST)
MIME-Version: 1.0
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Dec 2020 17:58:43 +0200
Message-ID: <CAHp75VcDJd_ROcPE6GJvz3J4fTp_a=PX2GpjRc3RV16edzYmrA@mail.gmail.com>
Subject: kernel bug tracker
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Does the I2O actually refer to IIO on kernel bugzilla?
In any case, default there is Alan Cox' email and I didn't find
Jonathan's there.
If the answer is "yes" for above, does make sense to:
 - change its name to IIO
 - put mailing list as default assignee?


-- 
With Best Regards,
Andy Shevchenko
