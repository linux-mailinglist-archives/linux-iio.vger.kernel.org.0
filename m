Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4A6796EB1
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2019 03:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfHUBK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Aug 2019 21:10:26 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:39261 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfHUBKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2019 21:10:25 -0400
Received: by mail-wm1-f48.google.com with SMTP id i63so401116wmg.4
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2019 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T9iBf6a01EUoyJeL0BKORzyCncq4SVoAwWt0B87jKfs=;
        b=htezgSxp6VnSyelzNfU8CBJaySjeYfmbWci88QYQvuKZikYit1H9DL+Fg68V9A+IKW
         dPv9X/Jy8xVPuOop9XvKmTN5jlsx48149Tgrh+Xv2YWHuIvKZGtMS6obYjbosBEoAqEt
         /+6uZzXKatAz/gHktQh3+3UJo6PnIb1KU80YDMKFamYB+W8pfBbjGeSVw42NtkvVr52k
         eigZc8XHnPKLzBVbr0G0Q/KUr0zjRAm7yTmEmQIFvaoQn50kwP2UZMlgzaJTLhkoX7zm
         OuNTR2UclWMUJea/RHjjHHeg5SmZTE/a72kU2ag+FA5mJcECrzQNlL+Q9G9yWhNXfUIA
         eBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T9iBf6a01EUoyJeL0BKORzyCncq4SVoAwWt0B87jKfs=;
        b=EssdubaYJW0RGGVXEhN2fcZRJMFs7OzDfKoWaxk7SKo/RfWruKtDEm69nI0AcHz3o1
         YsDZBv2jMV0pPRYGZxeiB39h9X/L/rVMmiMJ5fqhCo1hmpitrdnrDrdCGMUk5SPTC3dg
         Dapy2OQgth3Uv/lV6kCjyslRxbDUFJSD8y+xsOQwz9Yh0OpRqneLLPKdn26/rfJm2jjv
         XXfDBa/QqtITO5tqfGk3w3/2s9CqXO8898kNYKrqRtmLcfAEPgn3UtdvqUBPVvo0lL8z
         Y537wWS3TMvu+bGenaiwjfyJqlhCtal9x/uFZAmQeYG8rCiwi10F7zQK/hVPQtWzI+Wi
         UiDg==
X-Gm-Message-State: APjAAAUXVPIb+Ib3N2oMjuBl7WrP2aBjaW3jTdPwO1F/2WdJO5FSwuLa
        +zmQ6IP0EPLADX318F+0ZNQUnvDrrkiFEW7QBcU=
X-Google-Smtp-Source: APXvYqwYSDsLjC7r2VDGZ+gTOFO2EBRbNEakZc9+RjWehmnhEVuSXmbYEIaWbdifTiE4bk5i3sIpHmpWpxEWnbQ31PI=
X-Received: by 2002:a7b:c929:: with SMTP id h9mr2777370wml.1.1566349823637;
 Tue, 20 Aug 2019 18:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR19MB1657A46C8631408A8D0989049EAB0@DM5PR19MB1657.namprd19.prod.outlook.com>
In-Reply-To: <DM5PR19MB1657A46C8631408A8D0989049EAB0@DM5PR19MB1657.namprd19.prod.outlook.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 20 Aug 2019 21:10:10 -0400
Message-ID: <CAD56B7cOEvRVES8ZUtOo=J6U1Mwik51s+S=suoPBCOJ4H9ZNAg@mail.gmail.com>
Subject: Re: read buffer
To:     "Grim, Dennis" <Dennis.Grim@teejet.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 20, 2019 at 6:36 PM Grim, Dennis <Dennis.Grim@teejet.com> wrote=
:
>
> In user space, how is it known that data is available in a buffer (i.e. /=
dev/iio:device0)?  The buffer trigger happens on a separate thread.  I woul=
d like to do this without polling.  I have tried select() but it does not s=
eem to see new data from iio_push_to_buffers.

Hi Dennis,

What's wrong with just a read(), which will block until data is
available? You can put it in it's own thread if you have other stuff
to do. select() will work, it's a little more complex to setup
correctly, and isn't really needed unless you are waiting on multiple
fd's

-Paul
