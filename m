Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F37302A5D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbhAYSf4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 13:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbhAYSeH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jan 2021 13:34:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3A1C0613D6
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 10:33:27 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u67so8910331pfb.3
        for <linux-iio@vger.kernel.org>; Mon, 25 Jan 2021 10:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=TvxPdQjKCI9ZmZLVkYWALn/rUfjRsqwIOFEkOnlLvAs=;
        b=h9Y+HLhkNiDLbU77fvFncPIEguJ6e6m1erCgYBIBJfiuHVhuHTSX+oO5cGH0hfxcN9
         UcniZDt+ZRxHXhjXn6xobzm6nT6QPOmP0DV11gpz2BxB5EzvbGWklI+iqSzZ4Ym1RyXH
         GHk7A4gT2nddOvCwU6QBBKurFC6NYLfWUVWOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=TvxPdQjKCI9ZmZLVkYWALn/rUfjRsqwIOFEkOnlLvAs=;
        b=n7cqi2c0rXKecT5HeCEQdw8Tx8ztfvOHaHPjWitxAN9mreipzcwngtJhJrirscKyZM
         R/s0cg4LOfzNzRje2OGcfTmiflcc1fD3alEiXxr8n10Oas2842WmSYevySiC961XVqeH
         dC9RRHw1MC/iOgJ0NkybKqb+fDKt5P3PHPUP3wP3thddOHyr7b6wREyKXWUxzLQArD2w
         1fOVK7nR6B6gIzRH85Vu9HX0JDDcSPJaX3tLWgYo+zmUPiWCg/YVSJCbRNsNb9LEIIef
         PD6JU6/jA7YzqKh1KVeUI5CCX1ZU75hH+WAEmuvJcVN3jYigrStJp58WXJ4LLjyfBjtP
         Nd/Q==
X-Gm-Message-State: AOAM530uzrPGdSdZz2wJu0AzVzCa2z6W/ipVCh8P2taSqpnlthS82o0t
        TpL9ANacr3HrFVVvw+6u2X2g5Q==
X-Google-Smtp-Source: ABdhPJzoh/Cf5IXFpG6Oj3aBrXrIVCuqZqvLXHjyjI17esDA4GM7rda1RGFKlLlR64P3CLeZgDpURA==
X-Received: by 2002:a63:d84c:: with SMTP id k12mr1823571pgj.58.1611599606728;
        Mon, 25 Jan 2021 10:33:26 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:1066:b437:97cd:2278])
        by smtp.gmail.com with ESMTPSA id 83sm10584758pfb.68.2021.01.25.10.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:33:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUE2uvd+zyWQZm=LWM6sH7tCU8MUeZVo-zJrsWzLArXA1tROg@mail.gmail.com>
References: <20210122225443.186184-1-swboyd@chromium.org> <20210122225443.186184-3-swboyd@chromium.org> <20210124172756.69ef7c5a@archlinux> <CAPUE2uvd+zyWQZm=LWM6sH7tCU8MUeZVo-zJrsWzLArXA1tROg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: Add cros ec proximity yaml doc
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Mon, 25 Jan 2021 10:33:24 -0800
Message-ID: <161159960419.76967.7662401883849710311@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Quoting Gwendal Grignou (2021-01-24 12:42:56)
> On Sun, Jan 24, 2021 at 9:28 AM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 22 Jan 2021 14:54:42 -0800
> > Stephen Boyd <swboyd@chromium.org> wrote:
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: google,cros-ec-proximity
> Given we have proximity detection in cros_ec via specific sensor (si
> 1141) or algorithm (on-body/off-body via
> MOTIONSENSE_ACTIVITY_BODY_DETECTION), can we name the property
> cros-ec-mkbp-proximity?

Sure that works for me.
