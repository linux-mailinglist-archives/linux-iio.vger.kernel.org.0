Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20369C29C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Feb 2023 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjBSVFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Feb 2023 16:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjBSVFc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2023 16:05:32 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D5B193FC
        for <linux-iio@vger.kernel.org>; Sun, 19 Feb 2023 13:05:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id er22so4662620edb.4
        for <linux-iio@vger.kernel.org>; Sun, 19 Feb 2023 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gckypSBLD+AFrNIVEmiJhH6SMsrkXaBzRl4paLZn3Tg=;
        b=QEdCvQ0dbyxTiS7S+VABIMl+WlhdiYM1ol8WVyhlkzOrIY4uQrUlEIuLslpQkrqh1J
         eA3pGID8gtpTE4Wh8rG+uzDcIbUyePj2QXLJiwztkhGcOiCeycZdhoyx323xMLiRpM0F
         GL1pGUJOvK55Ku+euR13T78Aykl7th6a3G8Ou8GQfJJhA26JNmpkqdVExfLpBi6lZVuH
         RfzloS+UgxEi7f5OZdVerzEAl3eyzJdMr9upLpbeKWCbxacrGFB2xcH2maMVPmKErmQy
         4UbFXizohH4pn9Va+2Z8SLZf1iL9MEDWd+QrvrCITvB8AbaPO9tCziXnzWqQGdb/6DDP
         EJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gckypSBLD+AFrNIVEmiJhH6SMsrkXaBzRl4paLZn3Tg=;
        b=EzWPLN3oQ+fmIrO43W1HE7RUlfskWWU9U4GgDYUB7HffzZG5ZVnZrn8Pw39M+ya968
         5Q2vSQbUxriKx4ZFWpYLgM+xeqZobaDekMtroivW1CVZ69Sw6cgrqMRz/k/IKLnyEIsZ
         sJ06Tjvq7azc9/7+y8/uNSZIDTKbEvB0B+jKFEZg0tDo/eYkIdAGLHiGrMYKWTY7SUwl
         0botSiScquMCPCysLODAdbE9LqtNDbnHcXb7eol3OPxMH3QAjRokv4AXfSyrhW0bEZnt
         VOldMoT5cqTvDuJfRBiN1GrYnfT/pCV1wiA0RO92aJoHmoYhUMJDYj692QAvehmmEA1m
         sqQA==
X-Gm-Message-State: AO0yUKWu3F/CsMeDhMLKrId7K0gXvcOh1ta7Me+AZUrioEVvbi1Qjteb
        JIf5tNyfxZVpX4UvBDMtdFPoH40zz7/WeVgNKjYs46PeC6g=
X-Google-Smtp-Source: AK7set/uVWtKRGWj12laE3Fq/wLzIoMTR7wc7M+/DzoDZFu4xlDnA4wFchR0GJrOLecR9SzdozUaI8QhepuQR0ofw60=
X-Received: by 2002:a17:906:195b:b0:889:dc4d:e637 with SMTP id
 b27-20020a170906195b00b00889dc4de637mr2974085eje.6.1676840726910; Sun, 19 Feb
 2023 13:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20230219204439.1641640-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230219204439.1641640-1-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 19 Feb 2023 22:05:16 +0100
Message-ID: <CAFBinCCF_wSt6qd125f=7wzCPm21iz6ZbJ2oHGnPNBJy30y_DA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: meson_saradc: Better handle BL30 not
 releaseing the hardware
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Uwe,

I think there's a typo in the subject line:
s/releaseing/releasing/

On Sun, Feb 19, 2023 at 9:44 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> meson_sar_adc_lock() might return an error if BL30 doesn't release its
> lock on the hardware. Just returning early from .remove() is wrong
> however as this keeps the clocks and regulators on which is never
> cleaned up later.
>
> Given the BL30 not giving up its lock is a strong hint for broken
> behaviour, and there is nothing we can do about that: Just clean up
> ignoring the fact that we're not holding the lock.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Other than the typo (which maybe Jonathan can fix up while applying):
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Thank you!
Martin
