Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF957792F3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbjHKPYG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 11:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjHKPYG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 11:24:06 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FEDC
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 08:24:05 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d3d729a08e4so1948953276.3
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1691767444; x=1692372244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nccEPVxw1iruOgKTS2SOnwTQNJByLNy1GSBVvGk8Exc=;
        b=LSIho1Mi66mrsWFKupNAM3RZZ9BXIlZOY87i33iPMB7+u+yma20j0o0O2eH1lOLPe0
         Hme7QsvL6fV9V1CtD0q6Sq+MtF/5UUbIkr42ncwLdccZf2fv/8DegaWW3rnhWFTcMdwU
         sllKJIRPSXuS58Ycbp2UO2KrLPCzhRLFiys3RU23q+HXCE+U57lo5WwN5VIwwHAT2zuO
         JYzK9lwVyJsP91bTMWM9CFzIyCtp4uV/MLzZYVV0NzFAviklY775mz0ZaMBpFlCOiXzY
         QmMZFp7xjBvk5i+a3EWrqAq5YsceHt0ikIfKhr3iQnSDMe2N7n2iA1ZK2QQtuCZ5hrs0
         nd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767444; x=1692372244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nccEPVxw1iruOgKTS2SOnwTQNJByLNy1GSBVvGk8Exc=;
        b=KFiPkC+58QNgk0adSHvLa1DSJZoIr3g4kofddiI2M5DDm493RFdCKhdONtaUWpcZIE
         NN2afbLRhNxcqG+mkroA507uP4TrgODc4wGdpG7y4jnSj3BnqgAaarS3cW5ncfsY1nd7
         QtmcbeGMOM/PPWnMBxHM9c2kBKGE/v8H9dgeXHPj+v07b9g8580Y2jFjiBw8Fyw1GBTg
         y8KD/ZE/IgG7fX2AcaV4TSy+3jbs6CU0y0RyJu5i+hl4vBCX1QGpnBCsby4+QaBRpDiR
         KSD1rUtLv4iVX2OI+AgziXRmBfcKdWOAHAKhpJYyMtUjzzIVZw/gcrhJ0bcyLujZdkcY
         xwrA==
X-Gm-Message-State: AOJu0YwYdDtMEzwaj8NvPc2JyzUfRYd4baQjhsE4nlbt47L2YiVOniU+
        jiJg+Fe7wnvn0kWoQE423PxyounUzmmAnGMj4ni5sw==
X-Google-Smtp-Source: AGHT+IGPbXCNqf8mH3Te+LQsOvoYCD8VOIm/iuyU3ixjsbLlqc14iVqhJfiPoazeEqO+7CEzUp31zCGNyuwV62JUdfo=
X-Received: by 2002:a25:dcc8:0:b0:d15:9cdc:5d0c with SMTP id
 y191-20020a25dcc8000000b00d159cdc5d0cmr2197750ybe.42.1691767443978; Fri, 11
 Aug 2023 08:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMEGJJ3aiKUtTsHzVgbVEfiRUL+VV1zfc9-FoCRTjfWp4-=5ug@mail.gmail.com>
 <20230811162022.00002e20@Huawei.com>
In-Reply-To: <20230811162022.00002e20@Huawei.com>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Fri, 11 Aug 2023 16:23:53 +0100
Message-ID: <CAMEGJJ2YRfYPy9Wf+Pjou8N=8LB6wQaa+6fOqJ8FVLXo3d8FbA@mail.gmail.com>
Subject: Re: BMP180 (no) interrupt problem
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Fri, 11 Aug 2023 at 16:20, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 11 Aug 2023 10:08:00 +0100
> Phil Elwell <phil@raspberrypi.com> wrote:
>
> > Hi Jonathan and linux-iio,
> >
> > I've run into a problem running a BMP180 over I2C - it's on a
> > Raspberry Pi, but I don't think that's particularly relevant. As it's
> > a BMP180 it has no interrupt signal, but it apparently shares an ID
> > with the BMP085 which does. As a result, the driver and bindings
> > sensibly treat the IRQ as optional.
> >
> > The function bmp280_common_probe contains the following fragment:
> >
> > /*
> > * Attempt to grab an optional EOC IRQ - only the BMP085 has this
> > * however as it happens, the BMP085 shares the chip ID of BMP180
> > * so we look for an IRQ if we have that.
> > */
> > if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
> >     ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
> >     if (ret)
> >         return ret;
> > }
> >
> > where the irq is passed in from the I2C or SPI framework. Inside
> > bmp085_fetch_eoc_irq it immediately does:
> >
> >     irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
> >
> > irq_get_irq_data converts irq to an irqd, returning either a pointer
> > to the irq_data or a NULL. irq_get_trigger_type essentially just
> > indirects through the pointer to retrieve the irq_common_data pointer.
> >
> > There is nothing to prevent irq from being 0, and in the case of a
> > BMP180 that is the expected value. This is where it gets strange: on
> > an ARCH=arm build I'm getting a valid-looking irq_data pointer back
> > for IRQ 0, but on ARCH=arm64 I get the more obvious NULL pointer,
> > leading to an exception.
> >
> > I'm hesitant to suggest there's a bug in such old code, but I don't
> > understand why the condition in the probe function isn't:
> >
> >     if (irq > 0 && (chip_id  == BMP180_CHIP_ID))
>
> Agreed. That was my thought as well when I read the comment you quote
> above.  Worst that happens is we don't provide an optional interrupt,
> so this is a fairly safe fix even if the intent was something different.
>
> Mind you, it's also odd if someone provides an irq to a BMP180.

Thanks for the speedy reply. I'll put together a patch to that effect.

Phil
