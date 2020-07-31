Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9147234B44
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jul 2020 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgGaSjD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 31 Jul 2020 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387914AbgGaSjC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 31 Jul 2020 14:39:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A40C061756
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 11:39:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d188so8835894pfd.2
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2020 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2MAGMbg0u4EzY9Z9l4p+/acHke17WcznMZEaZyHXEcc=;
        b=SxedLiBl70jRZgMjL09LTz6KF3exiMTYiXug7VW80+AgMWc1+ohGWOj4p/CTBnW88j
         VtLRgmjdCcSbDPVnYwXnwfz0j8MrqU8Z96m2WJXxrb3Ve8rQY3VtEXxYxGriQV8ImRPf
         f3+K0ZX79JmFoW6M+sucgPGtQZDeKamLl1UYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2MAGMbg0u4EzY9Z9l4p+/acHke17WcznMZEaZyHXEcc=;
        b=VtdC26X6FtrockBVHRfW3kKCQizOjl5Id/IZabimsD2Q9KrNwO0o/JjhFfgJ1wvh+A
         EJB8sVR87z6WInNSzrrHBaVK1IpXQUWSUcDIcvqSWBAOdOacmy7w4ywhs9vVjeNFAuKo
         4r+dza3jpBluidlsGGJCGXIH9XG9P/C0V6IM+KW9sUUkP23aXKivFYBdezV0En7b2HDX
         YO7luB1JjFWXYHitz6ujxZiZ9WM0SOs8pVqedknAUOrqIv7y+2e8mwTAgIiP7qCRA+yX
         gUlW8GOp75MD6Kh0J3MgcFRi6r4F1kYW961F8GR6eG4UtI8tq2LGu4YEXj2UPH+B93Au
         GqQw==
X-Gm-Message-State: AOAM5307QPDZYjIU6jUEn5KJurOne2zXGzJAnlJGhEWXAo0zDeWbPxOs
        TMxS6ZnOB/NLF6wYVAMpUImFGA==
X-Google-Smtp-Source: ABdhPJwI+LOAoUwufpDS1NBdQDOdWsw1Fztrf8oLaj5V5undVeTE3iPXqrAKC/mNToSSt1hvcG6sqA==
X-Received: by 2002:a65:410b:: with SMTP id w11mr4854064pgp.65.1596220741843;
        Fri, 31 Jul 2020 11:39:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id io3sm9583665pjb.22.2020.07.31.11.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:39:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200731104555.v3.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
Subject: Re: [PATCH v3 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 31 Jul 2020 11:39:00 -0700
Message-ID: <159622074025.1360974.832515607486478547@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Daniel Campello (2020-07-31 09:48:45)
> Simplify compensation stage by using regmap_read_poll_timeout().
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
