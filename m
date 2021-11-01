Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB7441C8F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 15:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhKAO1F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAO1F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 10:27:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A5C061714;
        Mon,  1 Nov 2021 07:24:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id j21so42100675edt.11;
        Mon, 01 Nov 2021 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5UGjeB6DNxl1kWSnwRonjri/ccXMr+g+MmOLZdJOf0=;
        b=Tc6hO2FX4GpUMDDSIVM64QE1URSb9btNlh/IupmXlERV4yKXC+mPa26sb2WUxjlDDz
         Mvqwmv82zP4ErIGCs3ehtcxIjiqkLTazpDP7S5qKHtmfd3WAh9euaqQbAq4RA14bwACN
         HCqO8rNsW9ehkhojyFjZcE5qFZo1EUU5LMHFRGc5yd1n2Km5iBDbaylN5ClWxBP7eqQn
         ciQ/Gz9r67Fh+DwDyS+N37jt2vIrIW3Yb+zGRfBC/6x8dFKwKsifBdUc7c5mgvvQE68w
         iM1sKat04XshkCxxJ5mMMoKK6CTvw/v5vlswv4TR6G2OzyNZG/OEvbCwp4GgeDjo7mvR
         kuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5UGjeB6DNxl1kWSnwRonjri/ccXMr+g+MmOLZdJOf0=;
        b=w7PqJ/2GiOA9xCce5xIOr29R+Pm2WUfugeT+fCIQ/F9AsMOMrB9FGYfoLzJz02EJc7
         KevwSMYpiXYNhse4SgmAiBZMII5+8wtZTbcBjOV/Dwbpz4+sBGdLUhfXRxcfsthqd+dm
         MfCq7T5tYPHFM/Qv449PGVuaEOgkkjSI5xwFVojxL/wULyO4C8xDSkS/1p26H9EEDzTD
         dVmT3D4TC2R1qk4eZUskGty9OWSpjL7qld+RTgdwLG5lB1Ux55hoMBnnuBsd/+n/rnj3
         L+OkqMDzeuZBsY7y1DFSlW6iC+WPQs6tJR/PtVTTrB2j4hc1tMXK5rhJIysuE+XOf+Qs
         DMbw==
X-Gm-Message-State: AOAM530hljb4ANcfCVYa0xUrHJRqpY06FEBtD3y4Lt7hDswu+s6IdUUe
        iQjyrQa78utbdz0QDZdLrEpw5DQQeBv3g64iDm8=
X-Google-Smtp-Source: ABdhPJzSB7FAknw+ztQgPFkx9OcVslAk+VJQEoAjKvnOxeEwVkV96jhax1Rd4qgg8U6w0IFlTupR+waCQCnN0yEEkWc=
X-Received: by 2002:a05:6402:207c:: with SMTP id bd28mr31156598edb.240.1635776670145;
 Mon, 01 Nov 2021 07:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
 <20211024091627.28031-2-andriy.tryshnivskyy@opensynergy.com>
 <20211024171015.3b6b46e5@jic23-huawei> <20912d4e-8417-73d6-a42f-ceaada6e3cf3@opensynergy.com>
 <20211030154759.63be7331@jic23-huawei> <7efacdde-0c3a-36e0-bfc7-ef30c14cbf13@opensynergy.com>
 <4b53b3da-38b5-5c22-60bc-9f0731d6550c@opensynergy.com>
In-Reply-To: <4b53b3da-38b5-5c22-60bc-9f0731d6550c@opensynergy.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Nov 2021 16:23:40 +0200
Message-ID: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] iio: core: Introduce IIO_VAL_INT_64.
To:     Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jbhayana@google.com, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Vasyl.Vavrychuk@opensynergy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 1, 2021 at 3:54 PM Andriy Tryshnivskyy
<andriy.tryshnivskyy@opensynergy.com> wrote:
>
>  From 6e6a3661785584c6cc88370f78578810e67cb0e5 Mon Sep 17 00:00:00 2001
> From: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> Date: Mon, 1 Nov 2021 15:44:31 +0200
> Subject: [PATCH] iio: test: Add test for IIO_VAL_INT_64.

Something went wrong. Please, use the `git send-email ...` tool for the patches.

-- 
With Best Regards,
Andy Shevchenko
