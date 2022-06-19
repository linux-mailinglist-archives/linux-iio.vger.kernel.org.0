Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00339550D81
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 00:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiFSW7A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Jun 2022 18:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiFSW67 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jun 2022 18:58:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB2DCB
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 15:58:58 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c13so8314284eds.10
        for <linux-iio@vger.kernel.org>; Sun, 19 Jun 2022 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Tt7vn55TaGPlO3Jmka2oSGa/GCcjJ+9HdZrCafb4VU=;
        b=M7IvLzL3jZz/Qa5zsbH6qycgnzdeYiui8RFlFHpZFitiFjgLY7j7C5CffSkj6YbNMq
         eZQzXyBMFy68ApYmCqngatqmhJsWcZryu6X60n+/5USVXZQ1cVMIrLDagvifj+/7yZ4f
         djjIKfdPiUyxnRUFZV/Y+oQpLafgM3tnRn94Q4gJPCm8I2vuema9+V9EO5uLYFOCvDlb
         12usmCxvvVw61xXGeOlQRuH/nh3mKBEjCL9qkk2yEdjMB9cCneVPZI199w4reUmqMGJj
         jfzqht0iCceGQMgYuSipJNDwYIVU89QQpZoDtsCTwMlVFUrBenUussBGfgF6G9as5hUv
         bx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Tt7vn55TaGPlO3Jmka2oSGa/GCcjJ+9HdZrCafb4VU=;
        b=3nPruhaSt/BD0AoAYMQukkJubXwyo/ON/fU/eSbVq8+DQ68hICvkijwLKDXeJq3FPy
         hbGxDI9uQdUr6FcHfE64kjCxDSzoKab26w9c5J+HDrpN01hWtrsOBqOsJomfyl4xICG0
         YjTRbZ5PDplT4IE8r/Y4/FD8Wy0Muj+I96jtUESUDp13+eoeDR6qodTCg6YmzMA8S6DO
         SVeOgz2mAZgvJiibRrT8j9Q4MWeNLk4Uqox3BfYLCiagjHeud8y1A6GQ1TA8dNMjgCUG
         9+qz0Ibx501eU1K3vaIbE96s98duh2MOnH/Bkf/Fkmu6EikYxsnPro5sGYR7+PtAjkx9
         rkgg==
X-Gm-Message-State: AJIora+CZ+AId4Td7TSTytbnRdNy2MR7nbCHSggnNwaNaIQHo2xb2vDZ
        4vlfOU0Jh+u6I2ed956w3lsDd+TmGHzmDEsBHRM=
X-Google-Smtp-Source: AGRyM1vBmYx7d55eNUWk8kmh/vziTS/kAHsGRwqcaeAXmw+HiZBPhxa7r+VDFCeKoDxHWI7j0rldL0gMz9Rn15W8pNQ=
X-Received: by 2002:a05:6402:f8d:b0:435:6df2:68a with SMTP id
 eh13-20020a0564020f8d00b004356df2068amr11632530edb.209.1655679537137; Sun, 19
 Jun 2022 15:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220619185839.1363503-1-jic23@kernel.org> <20220619185839.1363503-3-jic23@kernel.org>
In-Reply-To: <20220619185839.1363503-3-jic23@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 00:58:20 +0200
Message-ID: <CAHp75VeEzASC+0wR31CsidAxGLG6uQAsb5wYWYgeEVeLrPNZMA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] iio: ABI: Fix wrong format of differential
 capacitance channel ABI.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jun 19, 2022 at 8:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> in_ only occurs once in these attributes.

Shouldn't this be a fix independently of the series context?
If so, adding a Fixes tag?

-- 
With Best Regards,
Andy Shevchenko
