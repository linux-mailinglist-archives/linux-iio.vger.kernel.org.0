Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA44E5F455B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJDOWM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJDOWI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 10:22:08 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403EA57BE3
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 07:22:00 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i9so5273610qvu.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=suFId2iCLwM3iNC+ZGhlQ1q9NuCiQSrErv1gwtmZyAI=;
        b=TgI+mzKkmowyPDHkj5aRg5/MnLax6nREMweQrA9+lnKDf/G5XuNGEUYt/yuf1MWlW6
         ws1bILeYmaCN36rOxBsSyVbDOdQUQ0HtESBFkEzFNSyCH7oMxmEeHsTGAXmYaUgOXxbi
         frGmhb5fpmWkH1jeNX3ReOj9ge4kl9Lce5VmxoremUvXhZZqW2tbRBGGigX617hX2a4+
         /OF4OATm29jnaTlJRDcdIEcBwQZJlWptfPvq6eOCPNcRwxxew4y/XCUkHHA3Mi1RtZHD
         JY2RJMr0wtvaptVKGqRYjmj/tJejwxLA/bzZmyndrXseWuRec9QD1JgJx5mpnWf8ym5y
         Rp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=suFId2iCLwM3iNC+ZGhlQ1q9NuCiQSrErv1gwtmZyAI=;
        b=LA9b4D+ZnLZ/vlrV/jvI0pu8kMMcg4ck+5mN4Czv9LYYiQpe+BkMKRVaxithlCyiV8
         VLg2asMlJcu33E+Li6lbQiI3MtegwttlCu2T0U9s3XtgYEQEn9c5OiqAY0e6O9cHiKYW
         p1PpjRK+H06m5VaN4vBLUbJaKT8iexWqHft4sKrCGB+e4BXyNozdP39eMSmYwNIFBrAT
         f1w1NcfOx3O0VLyy9z4vSLe8rTPnbjBwmt2v3os4cM70fV031yG4lwbHQ+hbR538M8RO
         MXPjnxbWGjA7G1wepkDhClbaMSsWk1oa5NgZQtoZRJKsaBFzyCHNnIGXjlbCx4S5Skdk
         1kqw==
X-Gm-Message-State: ACrzQf0NNXWMLbCUZmzPNnyTf4qW184nIJOYpUjiaFFbIZTg5hsDTfYA
        UkoKNoNERpQ7ZQwuvP3qFUqB8h/G77JpWMRj9MU=
X-Google-Smtp-Source: AMsMyM79UeFfxcu6tuAt1qmygbUhT0cOZvmlMo5V7vPJA336MwPg6X8Wc1O8L7QTv+XF3GiJfCQ++g/3+s50SA4s8U0=
X-Received: by 2002:a05:6214:29ee:b0:4b1:c1d2:6635 with SMTP id
 jv14-20020a05621429ee00b004b1c1d26635mr619419qvb.82.1664893316108; Tue, 04
 Oct 2022 07:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221004134909.1692021-1-nuno.sa@analog.com> <20221004134909.1692021-17-nuno.sa@analog.com>
In-Reply-To: <20221004134909.1692021-17-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Oct 2022 17:21:20 +0300
Message-ID: <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] iio: core: move 'mlock' to 'struct iio_dev_opaque'
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>
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

On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> Now that there are no more users accessing 'mlock' directly, we can move
> it to the iio_dev private structure. Hence, it's now explicit that new
> driver's should not directly this lock.

use this


I like the end result!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. Shouldn't we annotate the respective APIs with might_sleep() and
Co (if it's not done yet)?

PPS Reading to the topic:
https://blog.ffwll.ch/2022/07/locking-engineering.html
https://blog.ffwll.ch/2022/08/locking-hierarchy.html
https://blog.ffwll.ch/2020/08/lockdep-false-positives.html


> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/TODO                   |  3 ---
>  drivers/iio/industrialio-buffer.c  | 29 +++++++++++++++++------------
>  drivers/iio/industrialio-core.c    | 26 +++++++++++++++-----------
>  drivers/iio/industrialio-event.c   |  4 ++--
>  drivers/iio/industrialio-trigger.c | 12 ++++++------
>  include/linux/iio/iio-opaque.h     |  2 ++
>  include/linux/iio/iio.h            |  3 ---
>  7 files changed, 42 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/iio/TODO b/drivers/iio/TODO
> index 7d7326b7085a..2ace27d1ac62 100644
> --- a/drivers/iio/TODO
> +++ b/drivers/iio/TODO
> @@ -7,9 +7,6 @@ tree
>    - ABI Documentation
>    - Audit driviers/iio/staging/Documentation
>
> -- Replace iio_dev->mlock by either a local lock or use
> -iio_claim_direct.(Requires analysis of the purpose of the lock.)
> -
>  - Converting drivers from device tree centric to more generic
>  property handlers.
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-buffer.c
> index 228598b82a2f..9cd7db549fcb 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -507,13 +507,14 @@ static ssize_t iio_scan_el_store(struct device *dev=
,
>         int ret;
>         bool state;
>         struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
>         struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>         struct iio_buffer *buffer =3D this_attr->buffer;
>
>         ret =3D kstrtobool(buf, &state);
>         if (ret < 0)
>                 return ret;
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>         if (iio_buffer_is_active(buffer)) {
>                 ret =3D -EBUSY;
>                 goto error_ret;
> @@ -532,7 +533,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
>         }
>
>  error_ret:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         return ret < 0 ? ret : len;
>
> @@ -554,6 +555,7 @@ static ssize_t iio_scan_el_ts_store(struct device *de=
v,
>  {
>         int ret;
>         struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
>         struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
>         bool state;
>
> @@ -561,14 +563,14 @@ static ssize_t iio_scan_el_ts_store(struct device *=
dev,
>         if (ret < 0)
>                 return ret;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>         if (iio_buffer_is_active(buffer)) {
>                 ret =3D -EBUSY;
>                 goto error_ret;
>         }
>         buffer->scan_timestamp =3D state;
>  error_ret:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         return ret ? ret : len;
>  }
> @@ -642,6 +644,7 @@ static ssize_t length_store(struct device *dev, struc=
t device_attribute *attr,
>                             const char *buf, size_t len)
>  {
>         struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
>         struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
>         unsigned int val;
>         int ret;
> @@ -653,7 +656,7 @@ static ssize_t length_store(struct device *dev, struc=
t device_attribute *attr,
>         if (val =3D=3D buffer->length)
>                 return len;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>         if (iio_buffer_is_active(buffer)) {
>                 ret =3D -EBUSY;
>         } else {
> @@ -665,7 +668,7 @@ static ssize_t length_store(struct device *dev, struc=
t device_attribute *attr,
>         if (buffer->length && buffer->length < buffer->watermark)
>                 buffer->watermark =3D buffer->length;
>  out:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         return ret ? ret : len;
>  }
> @@ -1256,7 +1259,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>                 return -EINVAL;
>
>         mutex_lock(&iio_dev_opaque->info_exist_lock);
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>
>         if (insert_buffer && iio_buffer_is_active(insert_buffer))
>                 insert_buffer =3D NULL;
> @@ -1277,7 +1280,7 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>         ret =3D __iio_update_buffers(indio_dev, insert_buffer, remove_buf=
fer);
>
>  out_unlock:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>         mutex_unlock(&iio_dev_opaque->info_exist_lock);
>
>         return ret;
> @@ -1296,6 +1299,7 @@ static ssize_t enable_store(struct device *dev, str=
uct device_attribute *attr,
>         int ret;
>         bool requested_state;
>         struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
>         struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
>         bool inlist;
>
> @@ -1303,7 +1307,7 @@ static ssize_t enable_store(struct device *dev, str=
uct device_attribute *attr,
>         if (ret < 0)
>                 return ret;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>
>         /* Find out if it is in the list */
>         inlist =3D iio_buffer_is_active(buffer);
> @@ -1317,7 +1321,7 @@ static ssize_t enable_store(struct device *dev, str=
uct device_attribute *attr,
>                 ret =3D __iio_update_buffers(indio_dev, NULL, buffer);
>
>  done:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>         return (ret < 0) ? ret : len;
>  }
>
> @@ -1334,6 +1338,7 @@ static ssize_t watermark_store(struct device *dev,
>                                const char *buf, size_t len)
>  {
>         struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
>         struct iio_buffer *buffer =3D to_iio_dev_attr(attr)->buffer;
>         unsigned int val;
>         int ret;
> @@ -1344,7 +1349,7 @@ static ssize_t watermark_store(struct device *dev,
>         if (!val)
>                 return -EINVAL;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>
>         if (val > buffer->length) {
>                 ret =3D -EINVAL;
> @@ -1358,7 +1363,7 @@ static ssize_t watermark_store(struct device *dev,
>
>         buffer->watermark =3D val;
>  out:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         return ret ? ret : len;
>  }
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index c23d3abb33c5..ebbc64e4f673 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -285,16 +285,16 @@ int iio_device_set_clock(struct iio_dev *indio_dev,=
 clockid_t clock_id)
>         struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
>         const struct iio_event_interface *ev_int =3D iio_dev_opaque->even=
t_interface;
>
> -       ret =3D mutex_lock_interruptible(&indio_dev->mlock);
> +       ret =3D mutex_lock_interruptible(&iio_dev_opaque->mlock);
>         if (ret)
>                 return ret;
>         if ((ev_int && iio_event_enabled(ev_int)) ||
>             iio_buffer_enabled(indio_dev)) {
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&iio_dev_opaque->mlock);
>                 return -EBUSY;
>         }
>         iio_dev_opaque->clock_id =3D clock_id;
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         return 0;
>  }
> @@ -1674,7 +1674,7 @@ struct iio_dev *iio_device_alloc(struct device *par=
ent, int sizeof_priv)
>         indio_dev->dev.type =3D &iio_device_type;
>         indio_dev->dev.bus =3D &iio_bus_type;
>         device_initialize(&indio_dev->dev);
> -       mutex_init(&indio_dev->mlock);
> +       mutex_init(&iio_dev_opaque->mlock);
>         mutex_init(&iio_dev_opaque->info_exist_lock);
>         INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
>
> @@ -1696,7 +1696,7 @@ struct iio_dev *iio_device_alloc(struct device *par=
ent, int sizeof_priv)
>         INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
>
>         lockdep_register_key(&iio_dev_opaque->mlock_key);
> -       lockdep_set_class(&indio_dev->mlock, &iio_dev_opaque->mlock_key);
> +       lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_=
key);
>
>         return indio_dev;
>  }
> @@ -2058,10 +2058,12 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>   */
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
>  {
> -       mutex_lock(&indio_dev->mlock);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
> +
> +       mutex_lock(&iio_dev_opaque->mlock);
>
>         if (iio_buffer_enabled(indio_dev)) {
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&iio_dev_opaque->mlock);
>                 return -EBUSY;
>         }
>         return 0;
> @@ -2079,7 +2081,7 @@ EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
>   */
>  void iio_device_release_direct_mode(struct iio_dev *indio_dev)
>  {
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
>  }
>  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
>
> @@ -2096,12 +2098,14 @@ EXPORT_SYMBOL_GPL(iio_device_release_direct_mode)=
;
>   */
>  int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
>  {
> -       mutex_lock(&indio_dev->mlock);
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio=
_dev);
> +
> +       mutex_lock(&iio_dev_opaque->mlock);
>
>         if (iio_buffer_enabled(indio_dev))
>                 return 0;
>
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>         return -EBUSY;
>  }
>  EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
> @@ -2117,7 +2121,7 @@ EXPORT_SYMBOL_GPL(iio_device_claim_buffer_mode);
>   */
>  void iio_device_release_buffer_mode(struct iio_dev *indio_dev)
>  {
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
>  }
>  EXPORT_SYMBOL_GPL(iio_device_release_buffer_mode);
>
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-=
event.c
> index 3d78da2531a9..1a26393a7c0c 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -198,7 +198,7 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
>         if (ev_int =3D=3D NULL)
>                 return -ENODEV;
>
> -       fd =3D mutex_lock_interruptible(&indio_dev->mlock);
> +       fd =3D mutex_lock_interruptible(&iio_dev_opaque->mlock);
>         if (fd)
>                 return fd;
>
> @@ -219,7 +219,7 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
>         }
>
>  unlock:
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>         return fd;
>  }
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industriali=
o-trigger.c
> index 6885a186fe27..a2f3cc2f65ef 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -120,12 +120,12 @@ int iio_trigger_set_immutable(struct iio_dev *indio=
_dev, struct iio_trigger *tri
>                 return -EINVAL;
>
>         iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>         WARN_ON(iio_dev_opaque->trig_readonly);
>
>         indio_dev->trig =3D iio_trigger_get(trig);
>         iio_dev_opaque->trig_readonly =3D true;
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         return 0;
>  }
> @@ -438,16 +438,16 @@ static ssize_t current_trigger_store(struct device =
*dev,
>         struct iio_trigger *trig;
>         int ret;
>
> -       mutex_lock(&indio_dev->mlock);
> +       mutex_lock(&iio_dev_opaque->mlock);
>         if (iio_dev_opaque->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&iio_dev_opaque->mlock);
>                 return -EBUSY;
>         }
>         if (iio_dev_opaque->trig_readonly) {
> -               mutex_unlock(&indio_dev->mlock);
> +               mutex_unlock(&iio_dev_opaque->mlock);
>                 return -EPERM;
>         }
> -       mutex_unlock(&indio_dev->mlock);
> +       mutex_unlock(&iio_dev_opaque->mlock);
>
>         trig =3D iio_trigger_acquire_by_name(buf);
>         if (oldtrig =3D=3D trig) {
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaqu=
e.h
> index d1f8b30a7c8b..5aec3945555b 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -11,6 +11,7 @@
>   *                             checked by device drivers but should be c=
onsidered
>   *                             read-only as this is a core internal bit
>   * @driver_module:             used to make it harder to undercut users
> + * @mlock:                     lock used to prevent simultaneous device =
state changes
>   * @mlock_key:                 lockdep class for iio_dev lock
>   * @info_exist_lock:           lock to prevent use during removal
>   * @trig_readonly:             mark the current trigger immutable
> @@ -43,6 +44,7 @@ struct iio_dev_opaque {
>         int                             currentmode;
>         int                             id;
>         struct module                   *driver_module;
> +       struct mutex                    mlock;
>         struct lock_class_key           mlock_key;
>         struct mutex                    info_exist_lock;
>         bool                            trig_readonly;
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 9d3bd6379eb8..8e0afaaa3f75 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -548,8 +548,6 @@ struct iio_buffer_setup_ops {
>   *                     and owner
>   * @buffer:            [DRIVER] any buffer present
>   * @scan_bytes:                [INTERN] num bytes captured to be fed to =
buffer demux
> - * @mlock:             [INTERN] lock used to prevent simultaneous device=
 state
> - *                     changes
>   * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
>   * @masklength:                [INTERN] the length of the mask establish=
ed from
>   *                     channels
> @@ -574,7 +572,6 @@ struct iio_dev {
>
>         struct iio_buffer               *buffer;
>         int                             scan_bytes;
> -       struct mutex                    mlock;
>
>         const unsigned long             *available_scan_masks;
>         unsigned                        masklength;
> --
> 2.37.3
>


--=20
With Best Regards,
Andy Shevchenko
