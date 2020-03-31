Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BE4199D10
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgCaRkM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 13:40:12 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39365 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgCaRkM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 13:40:12 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so1367593pjr.4;
        Tue, 31 Mar 2020 10:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZGgZ/DpbtjfvIoAyjH9WXHlU0MAC6qI9epf9j+QkcKY=;
        b=th3yCmPTqqQGqzzkW/l97xkY9n6LcLBq0Q6woMFWev7XAzbKr1HS2mb/U3X3zpSIaE
         8g/PuCmSRKZkX4IdCvjw4Qk5syo6pKaBl3MRW9P9PzQ+PAa2YjXdZo467gT2hsO3aUWQ
         32/Ckxav4t5mEnYp0n50dSc3PisBJgeKXj+sW8pKeWDD1tgJP+5LpCcSwWrHr72DgeL1
         DkiKreZel2jBtxw1QLa1V3zDzsNNCSnDl8oPz6xEK/wUTA3Z+ljIy4tL3shrMmpofR32
         MG8tq1tapDMLsjir8Xemx9ANVGR3+xxCu+VEKofLlZoOnpqOUwiog3uGqHdrSAiBAux9
         YtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZGgZ/DpbtjfvIoAyjH9WXHlU0MAC6qI9epf9j+QkcKY=;
        b=TT1ggirRF8qwYI94fBHx6Yf6KkAPZ4XSzbztF3YSbUWVz5sBmq6QoLL1ij3YOOkXlp
         OGZKqLrfa5RwGYz7vtszMijdy927+5YiudVFOGlPitRh9TLyS/XnmGq3sUDufL5fOCy9
         8R9E6gVmfV73esg/9xirBwRmta0CDzfrTOj5UgnKr6r9q8dmVgCg99QUw80RK8/Ac60z
         TceOr23UqRvaGJuJ7EkFC+z6WMfSaEemXDJ7CmSrLADD7Q4DJp661wJ+awyZABAfLV8B
         +XdUR3L7xpYrk9ct33mck2iB5AH2lq5G+Cr49YLUz680Y64BOQO4U8MFWZJ0y55xgWt7
         Of0g==
X-Gm-Message-State: AGi0PuZ6cmlxpfA8RTAgXFnHKlLWKnqEGQdwUrxrwWcOvVUoQfTc11dQ
        ikckPp8TouHhqkJUpAvAg5Itf1MJm2yDV1bWhDQ=
X-Google-Smtp-Source: APiQypIQuOZDYcgwqK9kKPwJGPfZOl5Efak8sh+J533FlKJ/LbInbJDvdydB3qMebrD1YhQoYcmStt+VziIDAqwgmpA=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr5288873pjb.143.1585676409848;
 Tue, 31 Mar 2020 10:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-3-nuno.sa@analog.com>
In-Reply-To: <20200331114811.7978-3-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 20:40:02 +0300
Message-ID: <CAHp75VfXS1P-EJaKERojK=-3erYi5MxyDMjfrELyY2X3PZEN1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] iio: imu: adis: Add irq mask variable
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 31, 2020 at 2:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> There are some ADIS devices that can configure the data ready pin
> polarity. Hence, we cannot hardcode our IRQ mask as IRQF_TRIGGER_RISING
> since we might want to have it as IRQF_TRIGGER_FALLING.

...

> +static int adis_validate_irq_mask(struct adis *adis)
> +{
> +       if (!adis->irq_mask) {
> +               adis->irq_mask =3D IRQF_TRIGGER_RISING;
> +               return 0;

> +       } else if (adis->irq_mask !=3D IRQF_TRIGGER_RISING &&

'else' is redundant.

> +                  adis->irq_mask !=3D IRQF_TRIGGER_FALLING) {

But this condition rises questions. Why i can't configure both?
Why I can't configure other flags there?

> +               dev_err(&adis->spi->dev, "Invalid IRQ mask: %08lx\n",
> +                       adis->irq_mask);
> +               return -EINVAL;
> +       }

> +       return 0;
> +}

And actually name of the function is not exactly what it does. It
validates *or* initializes.

--=20
With Best Regards,
Andy Shevchenko
