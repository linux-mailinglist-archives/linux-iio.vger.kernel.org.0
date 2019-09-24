Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36725BC9D0
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2019 16:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbfIXOIM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Sep 2019 10:08:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22680 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729868AbfIXOIM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Sep 2019 10:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569334090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIrq5trXksk9vL3MEmG1ypUbrHtiD6lJvaDJ/2cf810=;
        b=OuYF1ZGLkirJMoV+U7Peylh583N4NkjGGcQVb6UIORZWrmUlfSSpAqRdyjob1SjupXbBt3
        YUX7iuO+7sWDv0QloX+Y0KKnpRywnnh+3AmPD7+h27A/PeoJ+zSOUwqS6/dPtL12GeLX1C
        kuKbSi/Eyfn+l9c5KczIJjnSeiRcYKc=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-ZsjQf8MjM6W7otavd7EvIg-1; Tue, 24 Sep 2019 10:08:09 -0400
Received: by mail-io1-f69.google.com with SMTP id g126so3299009iof.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Sep 2019 07:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcxxl5QuKVQheeuEj4joJPUsGAfiUx+0tBCRKSW0khQ=;
        b=NApwr7VY58w7NXjg6oK2RKKJdwlvqQuoCh/vqtcbmH5s1nlSWrz9gSpGu7Ts7/I4dr
         MIH3/25IND8X/+Lu9h9Zf9dllbVAEzyXW26UVhV2tYCZGAKuUtftXf7PwOC2xi1G7ePz
         QTe6fcVqkZmw/synSq9tdo5K0NhLQ9iJY1P1U0cBX44doJe1kPR763Gg2429nFrgJLt/
         /p09mSobUknJuPr9u8hByXyaKg9A6WQQOAmSMTXBgG0PK8pU68rXJFejv9E1jiXCeCfN
         oq3IP/DElqWRDjeoc/8CJ+aiMtXoJH6v9/ywy949i5YpFxTtrFxiUiQAV3vNUfVANtfg
         +6YA==
X-Gm-Message-State: APjAAAWSXHO0UptMckFhkcYFZTakTwgXUdCekJYloDPVVp8WmQ1Gf9t9
        9ofNzKK2w9hE88FXX9VmQ2NRKKnlncJSLlw366xTxIVgDw5dyNZkcAgPXZy9MIo+HYZA/m6cfDk
        YnanmLYd/Us8nxchjy4EhWN2ZxYYkS2aZro0K
X-Received: by 2002:a6b:f411:: with SMTP id i17mr3778528iog.201.1569334086783;
        Tue, 24 Sep 2019 07:08:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyVu27/zBoF2fHbORwSP9oKmc49nn0WnlXkqeG6LxB5vjwDNRFQPLr3y0hskpjTvML7m3gSzywiHF+Y41T185k=
X-Received: by 2002:a6b:f411:: with SMTP id i17mr3778499iog.201.1569334086536;
 Tue, 24 Sep 2019 07:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569143551.git.lorenzo@kernel.org> <9c8f80bf1b45e0144536220826558ff3b0bc18f7.1569143551.git.lorenzo@kernel.org>
 <929830d1-962d-55ea-e5bf-bf0a53f2fc5f@puri.sm>
In-Reply-To: <929830d1-962d-55ea-e5bf-bf0a53f2fc5f@puri.sm>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Tue, 24 Sep 2019 16:07:55 +0200
Message-ID: <CAJ0CqmXS3NQf6k7CfNQj29LcDPx7CQj+ph+kVyq5jp_Rhrs_xg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: do not access
 active-low/open-drain regs if not supported
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        rjones@gateworks.com
X-MC-Unique: ZsjQf8MjM6W7otavd7EvIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On 22.09.19 11:18, Lorenzo Bianconi wrote:
> > Move active low and open drain register definitions in hw_settings
> > register map in order to avoid to access them if the sensor does not
> > support them
> >
> > Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro =
unit of lsm9ds1")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  2 +
> >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 29 ++++++-----
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 48 +++++++++++++++++++
> >  3 files changed, 67 insertions(+), 12 deletions(-)
> >
>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Hi Martin,

thx for testing the series. I will rework this patch in v2 since even
LSM9DS1 supports Open Drain/Active Low.

Regards,
Lorenzo

>
>

