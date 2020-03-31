Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38497199D1C
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 19:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCaRlu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 13:41:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgCaRlu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 13:41:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id i34so531697pgl.4;
        Tue, 31 Mar 2020 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0WK1L776nmYgsU46xCXGDCiU0P0Wvlg3rNsyJsRlP98=;
        b=oXlHk8rqDvug0MKUD6I63bxufCaRC8Qv5IN1o81KbvCaUN2Ayl1AQb1oVDmmIKiCaU
         y+FKmCdXIQ/hd5W2+PQOjt9zCudi7Wlyqq4B+7n3d7Y2E+FpGVAkzNEdjUWWBQEPYDyb
         rJ8Rsli2qX1/AuOPa0sURyKOgzjlDPFGDr2Mdj0nwI3hImibl+jNacA7PWw0odV7rDji
         ZRWD7fxp+IyMvDagjNeJeUCELKz1eV2HlCBA3TSriuHmLMUzz0sqBTOPjHnFAAyOM0zl
         aRFQ6IVIdzbSGwLEo0wEG0fGtF4zI+9IVqhPSRqXUMn8zqe1fdQ0v5rpxqvCvmtrKfYt
         zgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0WK1L776nmYgsU46xCXGDCiU0P0Wvlg3rNsyJsRlP98=;
        b=sEWnnFvL4WYaphVc/5jGdb4Ua6JhiUfeDMfh1qE+UUfG6ZdH/YOpnYJ7T1jwltHKel
         zGlPZzCvriJuIiLmrEcdxGRkCTgWvoTqINo/C8WM2vSpcAzhu8OJEavzX+CUQQVQPp+S
         bf55RIJtWph+00Wn+iRoDOj2RWhlqj4CdEqmqrNGIRBHHvA2arL6xEgaIQHbX+9UebNr
         oSyp8ekPxc/bTANN5PS2Wwc54RwnW7cNrGrJgIn72SsemCXqrDOadT0So331n6N9Lktv
         KeavOw93COVAlOFRp6cunHuFj2YnOYLSFlmupL3BF5JCopsKCJmlL+ly9R+3O/xHAeuB
         s1UA==
X-Gm-Message-State: AGi0PuZSgWKGo3ueAMJQbgr7dLb+AO3MCKn1AosRyzAz8rgyS5WEdgFk
        CyKxmzH6aG82Viz3gGiSuirjkYdTMIcSdT9gAiY=
X-Google-Smtp-Source: APiQypLQFtXGfHUfvQUXhzwkFBcnNbPE4ORbACPZdwZJmr1jkPWgd79RsT3GiwhfIVOyeVAXF4niiNd0dLyr4hHQD/4=
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr5918902pfs.36.1585676508695;
 Tue, 31 Mar 2020 10:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200331114811.7978-1-nuno.sa@analog.com> <20200331114811.7978-4-nuno.sa@analog.com>
In-Reply-To: <20200331114811.7978-4-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 20:41:41 +0300
Message-ID: <CAHp75VdWa_-x4n+FwuZZ6a9pw19bejOGtx_VwWhvNAuSTYfgdw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] iio: adis: Add adis_update_bits() APIs
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
> This patch adds a `regmap_update_bits()` like API to the ADIS library.
> It provides locked and unlocked variant.

> +       __val &=3D ~mask;
> +       __val |=3D val & mask;

You can use standard one liner, i.e.

       __val =3D (__val & ~mask) | (val & mask);

--=20
With Best Regards,
Andy Shevchenko
