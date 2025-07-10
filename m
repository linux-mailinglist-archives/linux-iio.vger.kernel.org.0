Return-Path: <linux-iio+bounces-21509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F824AFFCD2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB4E58349E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B4228CF4A;
	Thu, 10 Jul 2025 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmgaNJaV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A8156F4A;
	Thu, 10 Jul 2025 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137625; cv=none; b=InofNi0aeo9j031P0ftO6mdCTqFR/w8M9YrSTlsmNhmZqElBcqmhv4ThYSNWVvh4ZJdpwLsfI9HZh/VP359RFzToW51l/O60yq8L8fpDP6zGTHF8XEBwJrPfRgX23bgStIX4jG4CglLSp3TA46eXKL90ngJdqZT7V0lbowCy1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137625; c=relaxed/simple;
	bh=j8B+TB81hLh/C1n4b+kDAND4dFAeJvtHpDR1GqvCfC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJX0WKx3lqUcaKciWEWgfs+KRSSPLpCUauw29afyetsb8UMO40DGbXxb/b8KYpCiKnr2ahiZUSIjPR1s+bsuYSzTmr4/MJGrIZSJv7OUXTtNrDO/dI46G6MgMX/i7anovAPF022YFrPKc4Zkk6vli7qAjMvKYRqInWUMCQLxF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmgaNJaV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso1259464a12.0;
        Thu, 10 Jul 2025 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137621; x=1752742421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69Ugmuq7ybV9YKhFzvOAb5xdvwi1/kSdd3sFQ7b/L4w=;
        b=WmgaNJaVLqPiOR7LIy6MqJtcP1fDEG+HCoJkjmukBJ+UbF6UmWdS8snEmt/nEoyN36
         PNtF1s+SaQvVnNgJAfs8Vym9M8gMRQ+1xAjV8xyz9CfK3rXo4djVs8EEAY3lb9J2IiFN
         eqnvuakm93tCCursYVUD2RTaWB0eM0aky4aiKrjjH4yexcIsKpY/K3L+7XBF3+u+wvCB
         Cml1e5tbV4vRfiQiVBlPA8gjlwOCqSMgexBJ6N5rHCnZKqqk5JTOtx9vRyp2s/aWS+te
         J234DIkSz04f+WEzi8vxou77Q7a7My/wZbx72Yez5VCWdc5o0Y64qCMOmjKMHcXTG4FC
         DMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137621; x=1752742421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69Ugmuq7ybV9YKhFzvOAb5xdvwi1/kSdd3sFQ7b/L4w=;
        b=VizJd1QQCqSnrm+m2vAUYL2NFEimrSBz40r0QTSUcnard+mr0rPis6xr6nVO4ikWKe
         fv1xOoONaj+F46tQHJoVE63GbcDLBqcmnijHpLC3s07Nwl+zuKMURC6YVSyJWzVOqTLP
         G2jOhO9W5+Pu3QdNiFg0umOPB+pPkkD8WeW3rSWQ30JrDhYJ8+EIymhmFdEUZU9lwXuN
         DISzkW4ptiW9hp/IK0W2DPLO1+Qciux7vUiC/5Rf09VQ/et5/xv5O2Kvm6dPmHiMxEpu
         CtOr2yVBAn6B/NfBROjJH/5ug1DgmkRO1S5JiyFtQLJGV7pTZUtDhcTHjjX2V7DyzVsW
         MDCw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Xw5HvvkIiucK06r6+YEKOUPmK7Fb7r0TP0UPXNfMNDBEqCnvYMUN7mt0FHO5tG8rkuJGpCOetErzz3JV@vger.kernel.org, AJvYcCVloVggDNjOB3p00rGtqjSxaIezGLAJGiwKVgK1xQXTM47GoUVyCWLwT+Ko6feTDsPHi2nq+YrTxtaxhWuE@vger.kernel.org, AJvYcCWfmW/pHk2yzmYgts4/sRG5Z2ib1CEeXuI4dOA6EOFiOmXK+ADBc1f3agUFybkQ9al9vxqNgutflMg0@vger.kernel.org, AJvYcCXAZYr16xrDvES9z8Is3wXrcMbG6lb6BMMlMCYhzWKAAR+YLjzU6NbdG1BICmK6XG8njT2FTSF3@vger.kernel.org, AJvYcCXroUoNhEtJpM0r+n7KQW1T+URzrLHvNhAL9DTqKk7K0C7P6qliH86ajHKAElsVlDEmvUbYgVC4chauYWHn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Kzngmh+twlArkdeg2cvO+ZrLr/EGp18By4wqCbEpFeklqri8
	baSF17za6qjfugWkDCmNi+8Fmm0UZNVsKyYjmxZVMcnCCWawZI1zDXtYoa51Q95xNAkz1YM7CYQ
	knBee1Yd7fv8tJRY0nGsZYwBzjPVq048=
X-Gm-Gg: ASbGncvlo+cuqm2csNk6bZaxbUKktisp3FzCEL9IRbxl7y1FlcZMxvcd0qt2qHtsx70
	EX1oPt1+q6RqFfpjk4SO4XT3dRM+joenpsNaF3u64l/cYZbT7cqLsHhwPns0o6oZVGnSS+DsHq6
	RBOVEUv3LvncYXrN34fYMl957skoo56oGFsb5d8VjJ+iXHFA==
X-Google-Smtp-Source: AGHT+IE/057CHjK/mOyiohxDHs24SY8jAE5xKdEv0ZJOoCjA/SIh8PibhxLy6qD7qDjnRhCyTxBW5bPj8u8UyJ1K09g=
X-Received: by 2002:a17:906:8f01:b0:ae0:d332:f637 with SMTP id
 a640c23a62f3a-ae6e13a247amr316221766b.31.1752137621158; Thu, 10 Jul 2025
 01:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-qcom-smgr-v2-0-f6e198b7aa8e@protonmail.com> <20250710-qcom-smgr-v2-2-f6e198b7aa8e@protonmail.com>
In-Reply-To: <20250710-qcom-smgr-v2-2-f6e198b7aa8e@protonmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 10 Jul 2025 11:53:04 +0300
X-Gm-Features: Ac12FXxhcKgMVc-WwlJ7x50JyK0vY6h0yIvi7Sw6HCxlOsEYDe0XTFuJUJDzFbg
Message-ID: <CAHp75Ved4cnpmiUzidoJqRbdnz=L-0F_KdyWifOOrZHUUf2KQA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: qrtr: Turn QRTR into a bus
To: y.oudjana@protonmail.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Luca Weiss <luca@lucaweiss.eu>, linux-arm-msm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 11:06=E2=80=AFAM Yassine Oudjana via B4 Relay
<devnull+y.oudjana.protonmail.com@kernel.org> wrote:
>
> Implement a QRTR bus to allow for creating drivers for individual QRTR
> services. With this in place, devices are dynamically registered for QRTR
> services as they become available, and drivers for these devices are
> matched using service and instance IDs.

...

> +struct qrtr_device_id {
> +       __u16 service;
> +       __u16 instance;
> +       kernel_ulong_t driver_data;     /* Data private to the driver */

Can we not repeat mistakes from the past and use const void * from day 1 pl=
ease?

> +};
> +
>  /* dmi */

Wouldn't it be better to keep sections ordered alphabetically so 'q'
will go at least after 'd'?

...

> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __QCOM_QRTR_H__
> +#define __QCOM_QRTR_H__
> +
> +#include <linux/mod_devicetable.h>

Not enough. Please, follow IWYU principle and include / forward
declare all this header uses.

> +struct qrtr_device {
> +       struct device dev;
> +       unsigned int node;
> +       unsigned int port;
> +       u16 service;
> +       u16 instance;
> +};
> +
> +#define to_qrtr_device(d) container_of(d, struct qrtr_device, dev)
> +
> +struct qrtr_driver {
> +       int (*probe)(struct qrtr_device *qdev);
> +       void (*remove)(struct qrtr_device *qdev);
> +       const struct qrtr_device_id *id_table;
> +       struct device_driver driver;
> +};
> +
> +#define to_qrtr_driver(d) container_of(d, struct qrtr_driver, driver)
> +
> +#define qrtr_driver_register(drv) __qrtr_driver_register(drv, THIS_MODUL=
E)
> +
> +int __qrtr_driver_register(struct qrtr_driver *drv, struct module *owner=
);
> +void qrtr_driver_unregister(struct qrtr_driver *drv);
> +
> +#define module_qrtr_driver(__qrtr_driver) \
> +       module_driver(__qrtr_driver, qrtr_driver_register, \
> +                       qrtr_driver_unregister)
> +
> +#endif /* __QCOM_QRTR_H__ */

...

> +       int ret =3D 0;

What is this assignment for? (The below is left for the context)

>         if (cb->type =3D=3D QRTR_TYPE_NEW_SERVER) {
>                 /* Remote node endpoint can bridge other distant nodes */
>                 qrtr_node_assign(node, le32_to_cpu(pkt->server.node));
> +
> +               /* Create a QRTR device */
> +               ret =3D ep->add_device(ep, le32_to_cpu(pkt->server.node),
> +                                              le32_to_cpu(pkt->server.po=
rt),
> +                                              le32_to_cpu(pkt->server.se=
rvice),
> +                                              le32_to_cpu(pkt->server.in=
stance));
> +               if (ret)
> +                       goto err;
> +       } else if (cb->type =3D=3D QRTR_TYPE_DEL_SERVER) {
> +               /* Remove QRTR device corresponding to service */
> +               ret =3D ep->del_device(ep, le32_to_cpu(pkt->server.port))=
;
> +               if (ret)
> +                       goto err;
>         }

...

> +       return ret ? ret : -EINVAL;

It's also possible

       return ret ?: -EINVAL;

>  }

...

> +++ b/net/qrtr/smd.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/skbuff.h>
>  #include <linux/rpmsg.h>
> +#include <linux/soc/qcom/qrtr.h>

Can we keep this more ordered?

Also include export.h when the code uses one of the EXPORT_*() macros.

...

> +static int qcom_smd_qrtr_device_match(struct device *dev, const struct d=
evice_driver *drv)
> +{
> +       struct qrtr_device *qdev =3D to_qrtr_device(dev);
> +       struct qrtr_driver *qdrv =3D to_qrtr_driver(drv);
> +       const struct qrtr_device_id *id =3D qdrv->id_table;
> +
> +       if (!id)
> +               return 0;
> +
> +       while (id->service !=3D 0) {

' !=3D 0' is redundant

> +               if (id->service =3D=3D qdev->service && id->instance =3D=
=3D qdev->instance)
> +                       return 1;
> +               id++;
> +       }
> +
> +       return 0;
> +}

...

> +static int qcom_smd_qrtr_match_device_by_port(struct device *dev, const =
void *data)
> +{
> +       struct qrtr_device *qdev =3D to_qrtr_device(dev);
> +       unsigned const int *port =3D data;

Why not

       unsigned int port =3D *((const unsigned int *)data);

> +       return qdev->port =3D=3D *port;
> +}

...

> +static void qcom_smd_qrtr_add_device_worker(struct work_struct *work)
> +{
> +       struct qrtr_new_server *new_server =3D container_of(work, struct =
qrtr_new_server, work);
> +       struct qrtr_smd_dev *qsdev =3D new_server->parent;
> +       struct qrtr_device *qdev;
> +       int ret;
> +
> +       qdev =3D kzalloc(sizeof(*qdev), GFP_KERNEL);
> +       if (!qdev)
> +               return;
> +
> +       *qdev =3D (struct qrtr_device) {
> +               .node =3D new_server->node,
> +               .port =3D new_server->port,
> +               .service =3D new_server->service,
> +               .instance =3D new_server->instance

Leave trailing comma.

> +       };

> +       devm_kfree(qsdev->dev, new_server);

?!?! No, just no. Please, fix the object lifetimes and use proper
allocators (not managed).

> +       dev_set_name(&qdev->dev, "%d-%d", qdev->node, qdev->port);

No error check?

> +       qdev->dev.bus =3D &qrtr_bus;
> +       qdev->dev.parent =3D qsdev->dev;
> +       qdev->dev.release =3D qcom_smd_qrtr_dev_release;
> +
> +       ret =3D device_register(&qdev->dev);
> +       if (ret) {
> +               dev_err(qsdev->dev, "Failed to register QRTR device: %pe\=
n", ERR_PTR(ret));
> +               put_device(&qdev->dev);
> +       }
> +}

...

> +static int qcom_smd_qrtr_add_device(struct qrtr_endpoint *parent, unsign=
ed int node,
> +                                   unsigned int port, u16 service, u16 i=
nstance)
> +{
> +       struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_s=
md_dev, ep);
> +       struct qrtr_new_server *new_server;
> +
> +       new_server =3D devm_kzalloc(qsdev->dev, sizeof(*new_server), GFP_=
KERNEL);

Why is the managed API in use?!

> +       if (!new_server)
> +               return -ENOMEM;
> +
> +       *new_server =3D (struct qrtr_new_server) {
> +               .parent =3D qsdev,
> +               .node =3D node,
> +               .port =3D port,
> +               .service =3D service,
> +               .instance =3D instance

Leave trailing comma.

> +       };
> +
> +       INIT_WORK(&new_server->work, qcom_smd_qrtr_add_device_worker);
> +       schedule_work(&new_server->work);
> +
> +       return 0;
> +}
> +
> +static int qcom_smd_qrtr_del_device(struct qrtr_endpoint *parent, unsign=
ed int port)
> +{
> +       struct qrtr_smd_dev *qsdev =3D container_of(parent, struct qrtr_s=
md_dev, ep);
> +       struct qrtr_del_server *del_server;
> +
> +       del_server =3D devm_kzalloc(qsdev->dev, sizeof(*del_server), GFP_=
KERNEL);

Ditto.

> +       if (!del_server)
> +               return -ENOMEM;
> +
> +       del_server->parent =3D qsdev;
> +       del_server->port =3D port;
> +
> +       INIT_WORK(&del_server->work, qcom_smd_qrtr_del_device_worker);
> +       schedule_work(&del_server->work);
> +
> +       return 0;
> +}

...

> +static int qcom_smd_qrtr_device_unregister(struct device *dev, void *dat=
a)
> +{
> +       device_unregister(dev);
> +
> +       return 0;

Why? Can't this function be void?

> +}

...

>  {
>         struct qrtr_smd_dev *qsdev =3D dev_get_drvdata(&rpdev->dev);
>
> +       device_for_each_child(qsdev->dev, NULL, qcom_smd_qrtr_device_unre=
gister);

Perhaps _reversed() ?

>         qrtr_endpoint_unregister(&qsdev->ep);
>
>         dev_set_drvdata(&rpdev->dev, NULL);

>  };


> +static void __exit qcom_smd_qrtr_exit(void)
> +{
> +       unregister_rpmsg_driver(&qcom_smd_qrtr_driver);
> +       bus_unregister(&qrtr_bus);
> +}
> +
> +subsys_initcall(qcom_smd_qrtr_init);
> +module_exit(qcom_smd_qrtr_exit);

Move these two closer to the mentioned callbacks.

--
With Best Regards,
Andy Shevchenko

