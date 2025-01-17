Return-Path: <linux-iio+bounces-14440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75663A159C6
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 00:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F791686C0
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 23:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691E91D5ACD;
	Fri, 17 Jan 2025 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="idHiBONh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65019CC27
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154982; cv=none; b=Je6q6360jxaiz5qDs2T8EIzixP00oDedtgasT4g5+06eanEg3XYuU3XLi0/kHE4iA8L0jHZkpZAx0jGC/l+so+AfiyQjBxQp1afzT/2NS/X3/35Qm6mLxUcrORtqTNWJVDunCzddQvdWdFDA2DCCo0geC/i2W4yNX+zpTjm5IsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154982; c=relaxed/simple;
	bh=XP7nWooumzzM9GcBE+Z9cCqJD3WzWiF502YZ50lJSbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kByC4Umrg0nBbVqxPfixSTxC2yKCx5eAjDZKpoOiqeehdcatnNgjWAxHBNYCt1Rcy+sJvVMd2/ic/rvujHFPZqNPnAc1CYT4FGsD0f41KqK2yF9ZrRbxm9+dfEnbxjH4BK87JUgwQWawHj1mKde6cFFT7Bb6t7n17jMwqwbro8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=idHiBONh; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5174f9c0d2aso783801e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 15:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737154979; x=1737759779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPFAicso8wU04TOj29PccqZl80rLIBhEzvUmMbwUsTs=;
        b=idHiBONh+IiC3DltmK9M6/mz7BV05vqh4j/PMaWAASYPmLfkdiSqSbv5rFznnZRMfI
         YJtBY0K4tmux4qAnOIF7KbSeTK/3a/VOJXH3hBib/10M2XyPfXrNM992g/fBPckGnnvT
         ewIenLB0gn3Mxs+GnfHzoi/rFk7jrSXs/kJFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737154979; x=1737759779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPFAicso8wU04TOj29PccqZl80rLIBhEzvUmMbwUsTs=;
        b=I4MZ1fgZkiVh1mJWgWifeUG+675XTC2+sD6+dFzW4pbuKZyRJhsM18XWQ/Yl/2atDC
         8YoH56q1ly2uCtMN/jbRh0hhuXDBp9kGytJmrHyXkx81HPZB3VeYpXjiJPa3YRIiR1iJ
         QkYUpf1hbXGrkJbiBR7sGJLItTICLUp8kwbeeaUFa6a6kaEMK/FMgM33KknTFndlVPWA
         ZYJ/uaMWKUl6FD5IfevolxILyYn9f2JV7kj2rR3GNjhlO10VlVib7E3+VsxRf6kZ8Eoc
         haIFvpc/xqW4KjcyNQxgwKFcm8RhISkpkmHnw1evqgbMrqBTGBcwA9VAde1ncpEH1E0m
         B0fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRMglfeFSUxepMusrXA+xYej2QTuQ+aL6pCz+D6pzfsw9DnF/DjoyI+dK7/QOpx6lG3zd1Ie2QQqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMZM3rNWx1Yoz1xMEWnKMTYPXcEx6vSvLs4ojZIIcq3BpYkJE
	NXCWQ0De1Z7OInIBS/USLgixSPBsGffPKLLX5+1yNpn1JYMdT83EEEF/7auMvk7v/Vf/KZ1pN/f
	WTqaTEd6dVj18WT0lUzv6iVztVeCgsxF80dwdE8zxuAWyT0c=
X-Gm-Gg: ASbGnctoPasPP+Oa3oTh3iUg0Z8fgjOUDTRUFwLgjiApvMXx0ljDEfGbGQCIRMsI65V
	jw6tm4xiF5BPZhxRU1GiO6BZ7gJFzWXqo3v/8eDJKjCm1bw2zmrZSldVkujzT8C+K
X-Google-Smtp-Source: AGHT+IHHUZ8K3xTCF/K6onjRcyjL5g0ZI5W1+nOvnREZMX64w8VjMUtV/F7GvUptN4bOp7ns/9dc3K4nONgMxcEN7X8=
X-Received: by 2002:a05:6122:3d46:b0:518:a261:adca with SMTP id
 71dfb90a1353d-51d5b301146mr4544781e0c.8.1737154979373; Fri, 17 Jan 2025
 15:02:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117042059.778637-1-gwendal@chromium.org> <20250117154705.00006d32@huawei.com>
In-Reply-To: <20250117154705.00006d32@huawei.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Fri, 17 Jan 2025 15:02:48 -0800
X-Gm-Features: AbW1kvYN-nvemJUFmCRdzeUAqBsRTfOmAaQzicCw7Q6BL_5237_0rhzEeMy-Xp0
Message-ID: <CAPUE2uvAtbxyosdorLuOKw_awnbVncy-qtFH=croiTfTSFP4RQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros_ec: Trace EC sensors command
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jic23@kernel.org, tzungbi@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 7:47=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 16 Jan 2025 20:20:59 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add tracing for EC_CMD_MOTION_SENSE_CMD command:
> > - decode the name of the subcommand
> > - provide internal information for the most common sub-commands:
> >   setting range, frequency, EC probing frequency, ...
> > - display return status.
> >
> > When enabled, the tracing output is similar to:
> > /sys/kernel/debug/tracing # echo 1 > events/cros_ec/enable ; echo 1 > t=
racing_on ; cat trace_pipe | grep MOTIONSENSE_CMD_SENSOR_ODR
> >  SensorDeviceImp-814     [003] .....   686.176782: cros_ec_motion_host_=
cmd: MOTIONSENSE_CMD_SENSOR_ODR, id: 1, data: 200000, result: 4, return: 12=
500
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> What this is missing is why?
>
> I'm not against adding tracepoints in drivers, but some statement of
> the usecase etc would be helpful. If it's debug only that makes
> for different requirements than some tool is going to connect to
> this stream.
It is for debug only, will update the commit message.
>
> Jonathan
>
>
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c =
b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index 9fc71a73caa12..075196ca804a1 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/platform_data/cros_ec_sensorhub.h>
> >  #include <linux/platform_device.h>
> >
> > +#include "cros_ec_sensors_trace.h"
> > +
> >  /*
> >   * Hard coded to the first device to support sensor fifo.  The EC has =
a 2048
> >   * byte fifo and will trigger an interrupt when fifo is 2/3 full.
> > @@ -423,6 +425,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sen=
sors_core_state *state,
> >       memcpy(state->msg->data, &state->param, sizeof(state->param));
> >
> >       ret =3D cros_ec_cmd_xfer_status(state->ec, state->msg);
> > +     trace_cros_ec_motion_host_cmd(&state->param, (void *)state->msg->=
data, ret);
>
> Can we cast to the right type rather than a void *?
Fixed in v3: `data` is a char array, but in the context of
cros_ec_motion_send_host_cmd(), it is a
>
> >       if (ret < 0)
> >               return ret;
> >
>
>

