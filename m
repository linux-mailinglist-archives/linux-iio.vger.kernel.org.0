Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A511959B988
	for <lists+linux-iio@lfdr.de>; Mon, 22 Aug 2022 08:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiHVGcR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Aug 2022 02:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiHVGcN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2022 02:32:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCADC286C4
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 23:32:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r16so11902324wrm.6
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 23:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=FrYubPa5iRhzf+WrRPsmiY5vXh9yxeGqcT0p84Sdu/VMPFizo2ximY48tx9ylUHZED
         mPTBYvFdQSWyQvZFeiwO+ZxRcjtLQByT4adG/DoNeZBMtMz8P1WBGCNUfwXOknCVageC
         gOsO411NxXs0bFn/r4hWP6vZOvFFR4JKHsjmj17OEFnj3UyoPLJL3/F0BAPtvb3VrkKu
         kt20y5+o7H2J6gAggdKUcj8w21Ihg/D6nYx+sWVa7eEOorpRHZwPseeMvJY9pUuIFhbk
         K7EW0i+70qlXOgawP99bZ1X3czl9u7y6nzREE0Ep8RS/WLsefyESE2bvTvChiDPA3pa9
         MIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=3ekNV3TH69TlactXozdqSUJc9+jfI8YlIEkHOtxkNbBdOk3PS4jxWKzyWnsi3TZ9v8
         fnlOUuGnckyntfvSgmIyFRE7PsNWgwgKvBGgfQGfCziqvPCI1ZcWttp+DgSqjBvdIkSQ
         CB3HyYWWaVz6gXPINnbFKk0haBJDFoXB3ekBZbsrZRtUIZiQ6EaJA/mxIFTHGU4Kf+py
         eJs/ldn4aRII6ViNrfyMefpvEX+UsHBomM4dhk7uFhMPSoNZ2VG4WkubTROVW9B/XXzS
         TrM7T2Pg7ZqT5JK+C2dzteEWDgLIP55IMcRLNkc16gTF31H1iUxuMU7odt3wysN3o9BO
         hwJg==
X-Gm-Message-State: ACgBeo2I8LLxzEzovI0wmn1miXpCwhB7wLHQVpaRE3QhCBV8HPFCeeJ3
        V2nIlFwct5N+XLg2dzRZZpiFRunv4vkD5dlg1lc=
X-Google-Smtp-Source: AA6agR6NTSbaljBeT6nBHwpsZV+iFEjaf84R55z0GxoNRdmBRntcrfv1xOl7luJnB44WOhlEhx6CPLwQoMYUPfF5qd0=
X-Received: by 2002:a5d:4ad2:0:b0:225:285e:3ec1 with SMTP id
 y18-20020a5d4ad2000000b00225285e3ec1mr9924326wrs.24.1661149927923; Sun, 21
 Aug 2022 23:32:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5444:0:0:0:0:0 with HTTP; Sun, 21 Aug 2022 23:32:07
 -0700 (PDT)
Reply-To: maddahabdwabbo@gmail.com
From:   Abd-jaafari Maddah <sheishenalyeshmanbetovichu@gmail.com>
Date:   Sun, 21 Aug 2022 23:32:07 -0700
Message-ID: <CALX-7+0_G-U-D9doENGdbc90dSeV5o=VML+dqaJkbMJ9UiPshQ@mail.gmail.com>
Subject: Why No Response Yet?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am writing
you again,it's important we discuss.
Am waiting,
Abd-Jafaari Maddah
