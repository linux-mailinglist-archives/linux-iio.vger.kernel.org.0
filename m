Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976A335079C
	for <lists+linux-iio@lfdr.de>; Wed, 31 Mar 2021 21:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbhCaTtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Mar 2021 15:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhCaTtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 31 Mar 2021 15:49:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0553DC06174A
        for <linux-iio@vger.kernel.org>; Wed, 31 Mar 2021 12:49:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ha17so10077934pjb.2
        for <linux-iio@vger.kernel.org>; Wed, 31 Mar 2021 12:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=32Kbmqg3krs7p25f4rHegFa5WMse8PFOAVaaQM1G2kY=;
        b=RID7sPvJRaiT505nWlLaHQPp0SOLeE5Inrx3h+T0Tjgp+1oZo3aWOEv7yXOaG5OP3U
         tLdPIiB62drBuH+ruCcxqHn+zb1d6z8Wzn1qAaDrkwXT5WBpAADab5PR53NjWMdjPyHp
         BpIvKijc5HnlljRdmwjgeRNqK82MybXqcOnqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=32Kbmqg3krs7p25f4rHegFa5WMse8PFOAVaaQM1G2kY=;
        b=qS8CDmGuIAwXiUZlWYQadfckhf4zu5ggxM7RWRPL9/EzHPguQNYBk1sDCpoYwOmJ9C
         QYuiD0a5GfJL0IVFpnPftGHh1kZ/sKgJA7KwGp+Fxsr7NNa2Xk9zzUYdC6u0RBcMEOTH
         UYT15jdMc2WxBqc9OUKc3ARkKkY8UZh1TakWZFzejxvEn9tLbiMs1q1RN8CgzzzfY3t0
         km4YQlDcvn16sAQlNTZ5rXZYx9yg15n3lG+Ful6ajm3jZQJ+Sl6ieHj/MkEN1UDVOrtt
         Film7mCzjD988xR1Q0gjMCjRCqNMyTY6YaoCCJqJ68J3yIpUJawhmMf0J7dhdlqYbHb1
         b0rA==
X-Gm-Message-State: AOAM530KxSASWucoxG61HFtDQ72NQ7klwJnZg22jxaMJaJv14Hwt0BjQ
        ZlpTggmKEBGBNZMTFO64T1OLOIoVDI7u7Q==
X-Google-Smtp-Source: ABdhPJzadUAI2e4f50j9jMf/MFgcJi23Kc1BCe7cqA1YDG9pbGtny7HLuW5ge9IjRZaZugoVIcDT+Q==
X-Received: by 2002:a17:90b:284:: with SMTP id az4mr5113153pjb.12.1617220160440;
        Wed, 31 Mar 2021 12:49:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:7515:8c2e:1867:2767])
        by smtp.gmail.com with ESMTPSA id l22sm3250010pjl.14.2021.03.31.12.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:49:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210331182222.219533-1-gwendal@chromium.org>
References: <20210331182222.219533-1-gwendal@chromium.org>
Subject: Re: [PATCH] iio: sx9310: Fix write_.._debounce()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        stable@vger.kernel.org
To:     Gwendal Grignou <gwendal@chromium.org>, andy.shevchenko@gmail.com,
        campello@chromium.org, jic23@kernel.org, lars@metafoo.de
Date:   Wed, 31 Mar 2021 12:49:18 -0700
Message-ID: <161722015839.2260335.4267819779077188735@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-03-31 11:22:22)
> Check input to be sure it matches Semtech sx9310 specification and
> can fit into debounce register.
> Compare argument writen to thresh_.._period with read from same
> sysfs attribute:
>=20
> Before:                   Afer:
> write   |  read           write   |  read
> -1      |     8           -1 fails: -EINVAL
> 0       |     8           0       |     0
> 1       |     0           1       |     0
> 2..15   |  2^log2(N)      2..15   |  2^log2(N)
> 16      |     0           >=3D 16 fails: -EINVAL
>=20
> Fixes: 1b6872015f0b ("iio: sx9310: Support setting debounce values")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
