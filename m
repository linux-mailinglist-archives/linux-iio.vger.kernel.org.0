Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2D46444B7
	for <lists+linux-iio@lfdr.de>; Tue,  6 Dec 2022 14:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiLFNjT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 6 Dec 2022 08:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLFNjS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2022 08:39:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36C6558
        for <linux-iio@vger.kernel.org>; Tue,  6 Dec 2022 05:39:13 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so23451810wrv.10
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2022 05:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbZUE6DWWVQx9WSKovRo796dpgXDEjE30nPkboWmubI=;
        b=hpRQ4/4FyXegzWXsf/Mr2GM+jHFkZGFAlgI7JuR0nkhgjgfr1nQyuTBQ29Kue++0Y1
         WFC5/b7T38+QiWB9GGgQgcGMjmGK8tn4AF/eEl+kUlhAGN/NsiBn3gBHGkgcC0Z5p2A8
         yWM3DEqYziYVPZerd+zPnPWwKdGGoAb5MZ5tjh2oDro26SKEVGcdHdAA7jW09LvUysih
         aJgGWi1RSydJmJdnQY4QBA2pq6Fxc9TS6I0oLNSRtyONFuIrGw5KyO6wolMSaWnUgabK
         6rdpfcaCqm9ak3BSiLkwACH8/hDtBi3C5XQUQARkbg+4zsFK8L15VgqzBR6Zj5M8gzOC
         dPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbZUE6DWWVQx9WSKovRo796dpgXDEjE30nPkboWmubI=;
        b=5DqllslRZhMThINL9B+Oqj3kZUQc9NhERefCnpPD650QgE66X2ybZXgo6Zs+ailjF1
         9/UZSAG1YYSaHq+iIuUWOjz+pHsMTx1IeH9EbFxOdH7I/1gthK9iAi7OHI4jhQ/fUQXi
         mCxNHQAQzSKnldU+mev2WKlaPYobj+Z1d+QkdnyALB9dC691ZXM5fDM08ZDeqmrEscYk
         K2NxT6uIWQfrruBMyRiO0RRQdxwAObJWYqCT4jQDLpB+jMiWjXv+v7h0jv/6kEws+ck0
         JSX2m7MprghuNFZF6UeJ0wOZ8i0AdGkgmDYNpOYyXUIyJveOSThDDnRVotOb9kFBsYnS
         EUXA==
X-Gm-Message-State: ANoB5pmwvCuAjj0pgcspWyV3RpFbl2lgZZDaiH6S74ueAuxCxICGMuZs
        n5lRYfXbKzWoHdEitN0PQickHmYlhFkMeDSijMM=
X-Google-Smtp-Source: AA0mqf4k+j1yTD2itXk+8nWZNk7Q7VV4Px+RuGLeF/VppBkOqcoF0FdiQtyQB8TMRu9J/EkbaO3zDcaLzeUbhHz9/Sk=
X-Received: by 2002:a5d:5a95:0:b0:241:65d4:8b41 with SMTP id
 bp21-20020a5d5a95000000b0024165d48b41mr51354635wrb.470.1670333952163; Tue, 06
 Dec 2022 05:39:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:47a5:0:0:0:0:0 with HTTP; Tue, 6 Dec 2022 05:39:11 -0800 (PST)
Reply-To: felixdouglas212@gmail.com
From:   Douglas Felix <pamelamcpeak181@gmail.com>
Date:   Tue, 6 Dec 2022 13:39:11 +0000
Message-ID: <CADnBHH=R-k493pvQUs+DrCSS-cEDCWV62bdT-YWRC-N5ak_PuA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to reply.
Kindly reply for further explanations.

Respectfully yours,
Barrister. Douglas Felix.
