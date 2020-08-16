Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E07245712
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgHPJ1R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Aug 2020 05:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgHPJ1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Aug 2020 05:27:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED15C061786
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 02:27:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so11470786wme.4
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2020 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqLkwHlBrUe1Q66EUAUl6az8odFlqZzo/jK8wUbkqT4=;
        b=vs/uNFROkVfof/aPREYnEAU+CqGR4cWgt/T1rBjkyhb8hVDx/a9PAJegkGzkC7w4ZR
         Tn1/7GYiW6ffAEvhBXEu8FxVZSx/VaqDlbWni8Yozw5gffTMsnaV+rMpvyfgQTB/sG76
         38UZGonX4BJRf6mKrlzIfe1Bu6FRl9298tLeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqLkwHlBrUe1Q66EUAUl6az8odFlqZzo/jK8wUbkqT4=;
        b=GomHRzYf0+gGRnpDZbQJw3fP4IKoIx79pBIbBl6Gbqyfww+1k8UjB4dfsDjPoTOL45
         cUTkfyWN6N4K+4gLu/bm9/YDMIiY0umwEXkNiPfJHkET3Vv6JfD8xRxvh6EzWV/xfSmc
         BopiayBWHeII0Qsj+PEMaw5I26fsA73vIZUbLsS6XXq7j0C3niJbC9yChdwguBK0zigC
         YfLubNblcoVu6pKxnYtEl4/bExlja0jdz5pvvoIu07ZwpEZ3Gh5Pi1DJeATVXIvY89Nt
         +Mg7/qto03vwApOpA0t8xPRDQF7ewNU7xGU/WlVXiQIpxnpaLWEbLaD2998FQlE7CQ/r
         U0Hg==
X-Gm-Message-State: AOAM532pA7XTsMuT9kXeL7F6cV+HeL4FBOk795GNAN94V3vHoEfRbUYl
        m5/t3RX6w2jE0pv+8Mysw+r6jJLgFRuDpDoY6VBrfA==
X-Google-Smtp-Source: ABdhPJwuCe4jc/FRxhU8pNlWdwIyF583UrTwZMzuxg5udgpW1LxZ6GzpKWFd/4TmDHrW8ROPtmf9BP4OLaUbrpOpciM=
X-Received: by 2002:a1c:24d5:: with SMTP id k204mr9719103wmk.159.1597570034175;
 Sun, 16 Aug 2020 02:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200811134846.3981475-1-daniel@0x0f.com> <20200811134846.3981475-3-daniel@0x0f.com>
 <20200816095215.6f3513d2@archlinux>
In-Reply-To: <20200816095215.6f3513d2@archlinux>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 16 Aug 2020 18:27:03 +0900
Message-ID: <CAFr9PXkPXOef1rSKbHSEFdSJiogwQN2hdM+fdEpkcfTa93igvg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] iio: st-accel: Add support for Silan SC7A20 and SC7A30E
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, 16 Aug 2020 at 17:52, Jonathan Cameron <jic23@kernel.org> wrote:
> Same issue with sign off.

I didn't think that was needed for an RFC. I'll add the sign off to the v1.

> + Needs to be added to the device tree documentation in
> Documentation/devicetree/bindings/iio/st-sensors.txt

I'll add that in. Other than that was the change OK? I wasn't sure a
massive copy/paste
would be acceptable.

Thanks,

Daniel
