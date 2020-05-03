Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB9C1C2AE7
	for <lists+linux-iio@lfdr.de>; Sun,  3 May 2020 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgECJcS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 May 2020 05:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgECJcR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 May 2020 05:32:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8924C061A0C;
        Sun,  3 May 2020 02:32:17 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so12111372wra.7;
        Sun, 03 May 2020 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Cj6PrKEWriLMFpm48Ydd3g92YYIzgDyg90exW8VfSds=;
        b=lb0xrE53eXxln857J9T3x+odmHCCTPyik7NZPWXS1FUIwpRp0zfbpVe2/j3Bi1EnYP
         4OZzHKax9QO/yAvxlbJ0oIgshJKxd2KxhOsthehHVdR//WtI7YFvOF6dDI+5REd2mAcK
         F7aiLT1Zm2+L8qTIJiMqJN6XcgQohImyt0ux2NGhA2my40Amv93BhjSO+eNf0ldnt9/6
         lcI/wu4/YP3wPtrYduIimJYnZALaX1AB0ziW0BNYMZ30pbn/BrKeyPHZlh7m77HqJjmz
         bF6gV5jhdzYQFm+9Q95fZnhpIoMWclLunBUW4I8bn1HrBarTCDtJuM38xI8VP6Y535Zr
         AfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Cj6PrKEWriLMFpm48Ydd3g92YYIzgDyg90exW8VfSds=;
        b=N/VC3+wnfJVb2dleSMo8mllt6pcmTdOb3vl+wA0G7pVLMZBB2MrOX+szroquY9FOF4
         cF9+caMWdmkoV/0rmjLkudBGWFqx0d44uuK2vUUe6OrXEbj7LgTIu467ki6QLuwP78WP
         0P4Zm2jW9CRn4UgxfY9/dMdc9jNthCz6YVmiqRwQrlNpwv1D638DAp3kEx5tKWeOk7p0
         McDJj5veMsmICjZP66JgxXXq3eH0eeS77gFyzNQoaRUd+Y+XhXS78p1OhNN6M8oPsznF
         fgA0vTgRQIud/eufhqbc9YAWyvzV8gvdvfJzXwM0PnuNRLXspZbIg4aeCkxDRrDsE0s8
         Wv0A==
X-Gm-Message-State: AGi0PuZVt/xKodsKlsN9uOxO6JLt/CrShH4DiwqH1ZlzkL0nzhyg4QT3
        XMdqdLOjRci5jXppLC7yaH14e61kHhk=
X-Google-Smtp-Source: APiQypIGt/MlW10tM/QPF5OSBJ6YVvQrqGkkd85fHGx/z3J5iQMhOQQxyg78Ml8NVUrtzu/0+Ni9fQ==
X-Received: by 2002:a5d:6148:: with SMTP id y8mr12918761wrt.236.1588498336147;
        Sun, 03 May 2020 02:32:16 -0700 (PDT)
Received: from meru ([2a01:cb18:832e:5f00:1cf0:acc0:9003:83d6])
        by smtp.gmail.com with ESMTPSA id 138sm8572524wmb.14.2020.05.03.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 02:32:15 -0700 (PDT)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: vcnl4000: Add buffer support for VCNL4010/20.
References: <20200427095559.16131-1-m.othacehe@gmail.com>
        <20200427095559.16131-6-m.othacehe@gmail.com>
        <20200503095653.06ef5c93@archlinux>
Date:   Sun, 03 May 2020 11:32:14 +0200
In-Reply-To: <20200503095653.06ef5c93@archlinux> (Jonathan Cameron's message
        of "Sun, 3 May 2020 09:56:53 +0100")
Message-ID: <875zddz7mp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hi Jonathan,

> One odd bit of code structure. If you didn't need to respin to fix
> patch 1's missing sign off I'd just fix it, but pleased tidy it up for v7.

Ok, fixed that in v7!

Thanks,

Mathieu
