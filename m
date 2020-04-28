Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997C51BB88A
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgD1IMB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 04:12:01 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:44325 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726442AbgD1IMB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 04:12:01 -0400
Received: from pro2.mail.ovh.net (unknown [10.108.1.145])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id BD66F4FEFD68;
        Tue, 28 Apr 2020 10:11:59 +0200 (CEST)
Received: from localhost (89.70.31.203) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Tue, 28 Apr
 2020 10:11:59 +0200
Date:   Tue, 28 Apr 2020 10:10:30 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Rob Herring <robh@kernel.org>
CC:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <jic23@kernel.org>
Subject: Re: [PATCH 5/6] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200428081030.GC6908@arch>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-6-tomasz.duszynski@octakon.com>
 <20200427212826.GA25672@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200427212826.GA25672@bogus>
X-Originating-IP: [89.70.31.203]
X-ClientProxiedBy: DAG1EX2.emp2.local (172.16.2.2) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 16523425560079719618
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedugddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujghisehttdertddttdejnecuhfhrohhmpefvohhmrghsiicuffhushiihihnshhkihcuoehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomheqnecuffhomhgrihhnpehoiihlrggsshdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekledrjedtrdefuddrvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehtohhmrghsiidrughushiihihnshhkihesohgtthgrkhhonhdrtghomhdprhgtphhtthhopehjihgtvdefsehkvghrnhgvlhdrohhrgh
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Apr 27, 2020 at 04:28:26PM -0500, Rob Herring wrote:
> On Wed, 22 Apr 2020 16:11:34 +0200, Tomasz Duszynski wrote:
> > Add SCD30 sensor binding file.
> >
> > Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > ---
> >  .../iio/chemical/sensirion,scd30.yaml         | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.example.dt.yaml: scd30@61: 'interrupt-parrent' does not match any of the regexes: 'pinctrl-[0-9]+'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.example.dt.yaml: scd30: 'interrupt-parrent' does not match any of the regexes: 'pinctrl-[0-9]+'

Well, a typo here.

>
> See https://patchwork.ozlabs.org/patch/1275131
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
