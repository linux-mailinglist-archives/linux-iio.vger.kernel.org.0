Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726076D5907
	for <lists+linux-iio@lfdr.de>; Tue,  4 Apr 2023 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjDDG50 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Apr 2023 02:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDDG5U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Apr 2023 02:57:20 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4779268C
        for <linux-iio@vger.kernel.org>; Mon,  3 Apr 2023 23:57:18 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17786581fe1so33434213fac.10
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2023 23:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680591438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2zcVLWRJStR8vsKQViB/xj+X74pI3lArdaI518I1/o=;
        b=BmdGsDihxTkHY8MUfqjQF0bV6rLxqM4osL/uj2PXHZryKSrbc/WcJih2gC436tLPm3
         ZWQHWHJOvcLLhNvQ8bbP3Fox4QjiTslMB2phxKeIkDG9D0buEQBNNq/nekvYuQrnVtni
         XxZbWnH0i6h41ciOWP+aeekyHPmlHZ6SZAdFS48YUhCa6XLgUlLJe9mepdqg2gq9La0K
         uOghCaMUKBBqc9z6lv/sV9b6F3ehzgyWwka2O5ugEfd9mNC6O+c74u2YQK/EBXeSVQ4g
         7UP9iISKUCH+IYENUEueJSodJxhQmDQlNh7vwHzaYbil8t908zv2AuS8NnzoPra1dGPm
         VErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680591438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2zcVLWRJStR8vsKQViB/xj+X74pI3lArdaI518I1/o=;
        b=obziKflmpEmNxuNQqZyUjfXjtsDVhYI7uGh1eNvQW5LxJn5rGOgOXE2UtmI63nfV8i
         DqZ/JuEf/Dn6Ddv30SOfjhl1XjN778x4UNk6IfQhuYJoQ0kwxTRREAWZDe0yYRZFHXQO
         aq0uji/gEtsKo3NFiRmbYQxEvur1jilr96beJS/ELBgK7Qk0N6qh1wf87trHeCZaa7Ef
         24igoV0wNpVpKim4cJfDBA3qOOPW71QIHgWgq/OTQkvXDpKFj/xvD0wf2slUMAHDm5tS
         3pwEaHcW21mqcyxBV7fh1FimeQs5DynrXoULW3E3R1l7Ux628lPY89ZqkKlCBoAIek+m
         aGvQ==
X-Gm-Message-State: AAQBX9e/zAN+JGgpixyAxpur6W/4ZSZZtOFqYWoGNI+4XaEEJP1r+VRx
        p3hgOo4mQTBPFFD8vN0qqBr2tIfSmOX0PcdMoBEbTtNxxIM94Q==
X-Google-Smtp-Source: AKy350YrD6VitPDM4MoUqn7BiQC4dXpCjRHMMOPr5PEF2EJYQH9GKSVvCuNYTqxYw+nvUaFupSOWd8fz3nYCzMnJD8w=
X-Received: by 2002:a05:6871:784:b0:177:bf3e:5d4f with SMTP id
 o4-20020a056871078400b00177bf3e5d4fmr831293oap.8.1680591438100; Mon, 03 Apr
 2023 23:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJMGm4GDVdAmwB4sHVkg78UhtVpmbCL6KT8-KbEY7cRSD5UZg@mail.gmail.com>
 <20230401152827.179d1a01@jic23-huawei>
In-Reply-To: <20230401152827.179d1a01@jic23-huawei>
From:   Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date:   Tue, 4 Apr 2023 08:57:07 +0200
Message-ID: <CAPJMGm4FkOmQkQ3H00kNR_gUCu7mAUiQS7OPi4jGEBccLEVv=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ad7192 driver: fix null pointer dereference in probe
 when populating adc input ranges
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     alexandru.tachici@analog.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 1, 2023 at 4:13=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Mon, 27 Mar 2023 22:02:48 +0200
> Fabrizio Lamarque <fl.scratchpad@gmail.com> wrote:
>
> > Fix ad7192.c NULL pointer dereference in ad7192_setup() when accessing
> > indio_dev structure while populating input rages, causing a kernel
> > panic.
> > Fixed by calling spi_set_drvdata after indio_dev is allocated.
> >
> > Pointer to indio_dev structure is obtained via spi_get_drvdata() at
> > the beginning of function ad7192_setup(), but the
> > spi->dev->driver_data member is not initialized here, hence a NULL
> > pointer is returned.
> >
> > By comparing every other iio adc driver, whenever there is a call to
> > spi_get_drvdata() there is also one to spi_set_drvdata() within probe
> > function.
> > It should also be noted that the indio_dev structure is accessed just
> > to get the number of bits for the converter, and no other driver calls
> > spi_get_drvdata within probe.
> > After the patch is applied the system boots correctly and the ADC is
> > mapped within sysfs.
>
> I'd prefer to fix this by changing the ad7192_setup() to take the
> struct iio_dev (available at it's call site) and avoid the dance
> that is currently going on entirely.
> Drop the struct ad7192_state *st parameter and get that via
> st =3D iio_priv(indio_dev);
>
> Thanks,
>
> Jonathan
>

Fix NULL pointer dereference in ad7192_setup() (ad7192.c) when accessing
indio_dev structure while populating input rages, causing a kernel panic.

Changed ad7192_setup() signature to take pointer to struct
iio_dev, and got ad7192_state pointer via st =3D iio_priv(indio_dev);

Fixes: bd5dcdeb3fd0 iio: adc: ad7192: convert to device-managed functions
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
V1 -> Revised after suggestions from Jonathan, removed Reviewed-by
 since the entire patch changed its content.

 drivers/iio/adc/ad7192.c | 6 +++---
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -380,9 +380,9 @@ static int ad7192_of_clock_select(struct ad7192_state *=
st)
     return clock_sel;
 }

-static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
+static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
 {
-    struct iio_dev *indio_dev =3D spi_get_drvdata(st->sd.spi);
+    struct ad7192_state *st =3D iio_priv(indio_dev);
     bool rej60_en, refin2_en;
     bool buf_en, bipolar, burnout_curr_en;
     unsigned long long scale_uv;
@@ -1073,7 +1073,7 @@ static int ad7192_probe(struct spi_device *spi)
         }
     }

-    ret =3D ad7192_setup(st, spi->dev.of_node);
+    ret =3D ad7192_setup(indio_dev, spi->dev.of_node);
     if (ret)
         return ret;

--=20
2.34.1
