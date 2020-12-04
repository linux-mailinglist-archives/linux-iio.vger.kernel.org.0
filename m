Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86B72CEE70
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 13:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgLDMy7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 07:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgLDMy7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 07:54:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A67C0613D1
        for <linux-iio@vger.kernel.org>; Fri,  4 Dec 2020 04:54:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r24so7469995lfm.8
        for <linux-iio@vger.kernel.org>; Fri, 04 Dec 2020 04:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJLdi4Czl4GekGouW7+yg12e9gQMljNyVv9TBzAvIgo=;
        b=k4phVhuyqlm0dM3mxJWEi25WjYDQadOLHCkENQRuPZN+UGgtDHITAs70JZj56R+Yds
         bMmIXUHhEKItf02UZJ9pZvyYoh2aqfWoEr8ygm8eZcCZ0LYmIAaSB/8uEo7WrD/P4Gs0
         CAvMsdk8xEIIkPeJo8q/N9OOzCK34uN3+kpzoSmIJWnO2GBIpiGFOOky0OxNtS9P7e1d
         3quKiXlG2G+tdi6OG1hD7EGeShI1bjUpahddJKu+aUpzVdPEalvYomWocZyWuoUxNMZA
         XD4n2rbDxvoy8ynAIkwQQfjbIFXqtqF8CnGfb7lCDqUlwVULG8b0lFuHgnzXYI1rdwN6
         MkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJLdi4Czl4GekGouW7+yg12e9gQMljNyVv9TBzAvIgo=;
        b=SJFM9O0QbPHPyuiys8FmidxNO9yXm/i+qEG/FErIHiB6QJigS5PWoSlcVjG4dybCvD
         wdSCR04956xaNRLZTe4yES0PWQsj7O+X0cAJuCSaMcP58pv8rVxVBLCTMrTNFx50W7kB
         qRctmGA18gbLUEfT8Qhx53k52wtx1FbnJ94EjdS+BW2khlbNfY7YK5oZ/gjG+qQLdWHL
         F/pqGONdWaacz8xjosS+6za4lIh33e00z/Q0l59FY6uUafUW1V8MC6zS+GtmA/t6bgAl
         NmJmONU1G9LiXtcuLRY1cY3PQ0CC3CSGHj0PCkthxYQH0OXiWzcBVNkgfRxjlp9G31MQ
         4JdQ==
X-Gm-Message-State: AOAM530SXQaNT+XKwI2D2clAbHwCQbkhU7yEAfK3Mg1cDRLd2BFeWrgA
        L+S5rF4wAQsRpL4rTopTL0JkSRtcjQO/9kTUSZO/w1yD/xm+kw==
X-Google-Smtp-Source: ABdhPJwphC+bViqoseJhRZxiu3a0zpxd5XBJ4UpG/DGVZjUx8bWY6Es0k2SxrjNDPIIbYct6gX2Qw2JcIEB2fpjO3Oo=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr3114203lfb.572.1607086451771;
 Fri, 04 Dec 2020 04:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20201203194612.3f35eda5@archlinux>
In-Reply-To: <20201203194612.3f35eda5@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 13:54:00 +0100
Message-ID: <CACRpkdbAy2ULtko65JsSbTMdgfL-i0GzCSaffSTPeF_YWr+HDw@mail.gmail.com>
Subject: Re: [PULL V2] 2nd set of IIO new device support, cleanups and yaml
 conversions for the 5.11 cycle
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Dec 3, 2020 at 8:47 PM Jonathan Cameron <jic23@kernel.org> wrote:

>       dt-bindings:iio:st,st-sensors: txt to yaml conversion.

Somehow I managed to totally miss that you made this conversion
and did my own conversion in parallel and sent out yesterday.

Oh well such things happen.

Shall I make an incremental patch or something? I think I could
just copy my binding on top, the diff may be a bit big.

Yours,
Linus Walleij
