Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA136DEAF
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 19:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbhD1R4F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243349AbhD1R4F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 13:56:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73673C061573
        for <linux-iio@vger.kernel.org>; Wed, 28 Apr 2021 10:55:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 20so29335910pll.7
        for <linux-iio@vger.kernel.org>; Wed, 28 Apr 2021 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=IXE4lrUTtC/fcZSSikTjmsNLf1BSdReBXiBTFFNlgtw=;
        b=lhvZrTRvPyx2bOUt4V1ow9GWRxQcqk8xh20XiFVxNWtvB9an/gWEUZXRC8xgLdb5Uy
         1UuLHJ9tS+Hn9quaAU7z2ojpuK1z3xtrAJy+/R9IeU7EOyTeGsrOr8yKq/r+UN1Yyt3y
         0cjmvuqNCM/O0iQIC/Bb+1MF1cFpT4J6+bIk46Cja/uu3Ny4Lpu6aZGIU2uZ0zfnBm5o
         BIAhY56r0lIoDuM1/YRAJDSpfJ+ACK96zZye4cBkewAMKcl99HVhuohcVV8ni505xOc4
         qM0n6KyQ8hq/5794a9jVABDPoHECt473366dojQklrELjejdGlHTozeAZjib5Yy2aLj+
         iDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=IXE4lrUTtC/fcZSSikTjmsNLf1BSdReBXiBTFFNlgtw=;
        b=gkFpkDmlCcPQjoQzm2lq4xYdlNBsGLQaAdITGIwuGe3u7IofrMmdPSRledX40kz5b+
         oAnFqOdEazRYKfAu9B642cMDXKIna3wj2V+f/3U8H3xiveOIVQwbGJE59dXiUbYTxEKj
         HhK0CgCRtyIWgeOyzrpy/3xCsX/2+Rq96BBfmGd468Woe7ioo0ZwxWg6q9OMmo6dXMQk
         cLA5vwwZY/9tDzeRZGb7JFL4ZN+dIIDMX00exFKyvUpgFLQTloSDa6SrXN2FtO5wuYp9
         3jh9IMFjsFU4Nv+aOf3iYVEI8gJICYsYAnvvQpEX/EiGpjekTAFgQXHJ3ve6s44DVCkl
         W3gg==
X-Gm-Message-State: AOAM532eI6Z0L1ZPw3WWtxV1ghJ70cpGkEUdDwuchY3bazVyyy5LfYev
        DrFtTN5+2qVS30GenHwdEVLwdYkd3EN+z58l3TY=
X-Google-Smtp-Source: ABdhPJwn7OCgR8VAlURIbAb6MoerM9wnhdBaUs2t+InWP/fv4oBqne1g+pcI3mvnhrjrelMH8o3J4GVsh9n7tIyWbW0=
X-Received: by 2002:a17:90a:6f45:: with SMTP id d63mr5194600pjk.39.1619632520069;
 Wed, 28 Apr 2021 10:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:7f9a:b029:1d:2140:cffe with HTTP; Wed, 28 Apr 2021
 10:55:19 -0700 (PDT)
Reply-To: k238336@gmail.com
From:   Joseph Kallu <davidottih0@gmail.com>
Date:   Wed, 28 Apr 2021 10:55:19 -0700
Message-ID: <CAHvD5oaTDV6AZiODfbjiA8tffi8RKb5cnj2p0A3hnJLX25Pt6A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

0KXQtdGYLCDRgdGA0LXRm9Cw0L0g0LTQsNC9LCDQv9C+0YHQu9Cw0L4g0YHQsNC8INGC0Lgg0LUt
0LzQsNC40Lsg0ZjRg9GH0LUsINCw0LvQuA0K0J3QtdC80LAg0L7QtNCz0L7QstC+0YDQsCwg0L7Q
tNCz0L7QstC+0YDQuNGC0LUg0L7QtNC80LDRhQ0K
