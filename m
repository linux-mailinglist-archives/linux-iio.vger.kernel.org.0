Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC32D3D26
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 09:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLIIMp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 03:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLIIMp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 03:12:45 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BF6C0613CF;
        Wed,  9 Dec 2020 00:12:05 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id z5so728655iob.11;
        Wed, 09 Dec 2020 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZkX9tdFl/5xUvaDKSjaYtNLHiyyY32tOU1vqsevSlcs=;
        b=UQVm+Q8bJF9zCUgJB+pZXr9R14n7oP0TRfLu27+SQLw4Nti8/vx48iV/5/Q1pz7m+H
         7k95j/OcchHU6h20StigA+VZtLxFvccZgHUHY33vngZ/P/STANMb4HdLlX7Jf2Ef65zZ
         IMezTWsHID1DfsLYGmYrQQ6/M+68OcwpjQR+WyRfWJGMR/FHsud5iCReKzptcL5+G56e
         uiNm5FAagwmzh0dC6t5XFp6mUwlDRwD/GgusecBvjCDnMhA8EKvUCkiSSIMySzOmoQYv
         N1LciSYIMHD/Tm42JQJzMagoUNC7XWi1TRjuJPES91Vv07PnNV3k+8Y3Z+AdWud9qnYE
         tTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkX9tdFl/5xUvaDKSjaYtNLHiyyY32tOU1vqsevSlcs=;
        b=kdH4oFrUblNpVK8dzLXMBD+yhXUrnEy63ttiFZ2w91MCYFzk2qyXbLmqdsaWI1L3vS
         W1BN3N9ScDM24Uwt7z3fjEDPaTsu1iaiyIEpkI0m5sRR+p3CPG1kUbY4qrGea7cICL6+
         ULIA6xb2ZAe89MkoZg3Hsc0jG250SX2nykF/gfEPXBpSiMwiqrlnO4VKtQ2WUvyVkQyj
         CMr84iQ+uptfUaC9+S+bdhBHdRo86XkBV/fetAboWt5mm950vH+6pdfaazmd885pv329
         Ls5UDGn574cUriHP1MxHPg2INYWLEBvPJfiE30XhYIfP6uXEABswQ3GzhKRU12arGaFL
         KohA==
X-Gm-Message-State: AOAM533DR82FSRhzh5+O42w/CjMCtuaeVZ92GVmZq54iNdB8jgfkxajM
        ZkBwSII0vmtwLAjNb9RE5Wj3Fudn5nk5xyhN1Eo=
X-Google-Smtp-Source: ABdhPJw4tNRdplp2hiWVXPqiP2gSxxj51H2r6eMwGrrsGeuZlXL3QQ4n3XnsSoBAENpdJ92Zag21SqEuUjwrR/5t9bU=
X-Received: by 2002:a5d:854f:: with SMTP id b15mr1349884ios.170.1607501524428;
 Wed, 09 Dec 2020 00:12:04 -0800 (PST)
MIME-Version: 1.0
References: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
In-Reply-To: <CANk7y0gAChikUBf-ap328YNQd4nrw63BiFH9dRLLDuZ0SnneMA@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 9 Dec 2020 10:11:53 +0200
Message-ID: <CA+U=Dsr=SCdSsbsbdY++NwD4xQjr6PZuoOqa_Ctq6ig+GuvO=w@mail.gmail.com>
Subject: Re: IIO Driver for TMP117 Temperature sensor
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Dec 8, 2020 at 6:10 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> I have this TI's TMP117 sensor with me and I was thinking about writing an
> IIO driver for it as a hobby project. Is the IIO subsystem the correct
> place for this driver? if yes, can someone help me get started with this,
> I haven't written an IIO driver before. I have this sensor and also a
> raspberry pi with me for testing.

This could also fit into drivers/hwmon.
Looking at the HWMON subsystem there are more TMP drivers there
(TMP102/103/108/401/513).
The first 3 seem a bit more similar to TMP117 (in terms of register map).

Let's see what others have to add.
But, all-in-all whatever driver you end up writing, the easiest method
is to copy an existing similar driver and extend it.
Sometimes, a part can be added to an existing driver.
At a quick scan through existing drivers, it doesn't look like TMP117
is similar to existing drivers, so it may require a new driver
altogether.
I may have missed something though.

Thanks
Alex

>
> --
> Thanks and Regards
>
> Yours Truly,
>
> Puranjay Mohan
