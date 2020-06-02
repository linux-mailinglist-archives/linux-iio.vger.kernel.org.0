Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB5B1EC1A4
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jun 2020 20:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgFBSK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Jun 2020 14:10:28 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251]:45681 "EHLO
        smtpout1.mo528.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgFBSK1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jun 2020 14:10:27 -0400
Received: from pro2.mail.ovh.net (unknown [10.109.138.132])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 998EB607FDC3;
        Tue,  2 Jun 2020 20:10:25 +0200 (CEST)
Received: from localhost (34.103.240.103) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 2 Jun 2020
 20:10:25 +0200
Date:   Tue, 2 Jun 2020 20:08:13 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 0/4] Add support for SCD30 sensor
Message-ID: <20200602180813.GD2668@arch>
References: <20200602164723.28858-1-tomasz.duszynski@octakon.com>
 <CAHp75VdPF=LzDn0f_Ljb=S+8L58DS4ofC6fD=Nzu1afR_nD8vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAHp75VdPF=LzDn0f_Ljb=S+8L58DS4ofC6fD=Nzu1afR_nD8vQ@mail.gmail.com>
X-Originating-IP: [34.103.240.103]
X-ClientProxiedBy: DAG2EX2.emp2.local (172.16.2.12) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 10813424183108459679
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtheevtefhffduteejfedtkeeuheejgeejvdetfffgveekffefgeffueeghefgjeenucfkpheptddrtddrtddrtddpfeegrddutdefrddvgedtrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtohepphhmvggvrhifsehpmhgvvghrfidrnhgvth
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 02, 2020 at 07:55:55PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 2, 2020 at 7:49 PM Tomasz Duszynski
> <tomasz.duszynski@octakon.com> wrote:
> >
> > Following series adds support for Sensirion SCD30 sensor module capable of
> > measuring carbon dioxide, temperature and relative humidity. CO2 measurements
> > base on NDIR principle while temperature and relative humidity are measured by
> > the on board SHT31. As for sensor communication, both I2C and serial interfaces
> > are supported.
>
> Btw, since we have relaxed 80 limit to 100, I recommend to reconsider
> some lines to be joined.
>

Heh, that particular change is becoming more viral that corona itself these days.

> --
> With Best Regards,
> Andy Shevchenko
