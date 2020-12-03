Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1562CCF34
	for <lists+linux-iio@lfdr.de>; Thu,  3 Dec 2020 07:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgLCG16 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Dec 2020 01:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgLCG16 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2020 01:27:58 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E394C061A4E;
        Wed,  2 Dec 2020 22:27:18 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id v1so547823pjr.2;
        Wed, 02 Dec 2020 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JIdff1VBF+uP5SziDcHY7x/1uDEIyNK1HGkkO+Ce1xk=;
        b=IofT99cLgaFaJORr+HbK7jwv4M7wNQrOzi+3OMaqTH2qKYyxCTOR/4n75dJV550QTZ
         esfx/SEMJNju/ZaA5nlmWN/s3dBlE2mITEbov+NZCL1L3+ZGV3+IfQ/WFQqKF0h8B/Xk
         QoCKlrelkKy0dcHuagzdWnsZnqLfPdk8J6aghrhpF0U80hxw1SRt9fbiT0EpN1CAvtJO
         LtpR/nTDt3KyIJGP4cAPTtAR3PxSYLkd7foCS9vfpjZFaEHFL5tRG68mUeJLrUPV56vH
         1DK4PWNB/GQPqJMsuRTCarqVp+nPOz9R0ckl03ZSxeLtNWcZOP6I+EcC68YoCLLRB1Vq
         DZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JIdff1VBF+uP5SziDcHY7x/1uDEIyNK1HGkkO+Ce1xk=;
        b=GiLNyANFO1n1EBwu3YWnpcSstxSF7NWPUm5hY6CudIUczKZYlvKqEnyLmg/nzsrCO5
         ai5C264zJVDWqhtadbGGeYt4d3pwg7OJHctVBMnCwU1FooinsFtOW+sppv+z1+IAAXS8
         nA+f1al88D++/dCNoGPq+aENLQb1p/W7G0y5ibfnArGRFs6oYwRdP+hexICN5oHK9t8k
         JHx97hJszl5LqqFmIe/fzd1vZtf+uC2n7O3p4CQ9GjlARoxDv3l2HLoDE7rcwTAVR9QC
         KgvFr7e48g5PLzpowpzBw0EAh5a6MDZta5ShuA9AQmMyAj4Sim9PL3jP/LOV/ROtisuv
         0S9g==
X-Gm-Message-State: AOAM533THHdYPQfdy5ueGM7TqZeH+24jYDrwbolRM7QxvURZnsWFJyDv
        xIIL5g5d3S4Q0IVs7nFAI3Y=
X-Google-Smtp-Source: ABdhPJyjSNv/C2l8ZtaC9KjD/0k/cr478E0J4aUuV0nD73oFdnOeF77Iv6agw2RiQxq+Tc6d+K+PHg==
X-Received: by 2002:a17:902:9891:b029:d8:fdf6:7c04 with SMTP id s17-20020a1709029891b02900d8fdf67c04mr1727757plp.54.1606976837830;
        Wed, 02 Dec 2020 22:27:17 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id o9sm277249pjl.11.2020.12.02.22.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:27:17 -0800 (PST)
Date:   Wed, 2 Dec 2020 22:27:13 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        kernel@collabora.com
Subject: Re: [PATCH v2] Input: document inhibiting
Message-ID: <X8iFQfsZSh0aV+pX@google.com>
References: <f9007f37-c526-5fa4-3188-a554d2434177@redhat.com>
 <20200617101822.8558-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617101822.8558-1-andrzej.p@collabora.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jun 17, 2020 at 12:18:22PM +0200, Andrzej Pietrasiewicz wrote:
> Document inhibiting input devices and its relation to being
> a wakeup source.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

Applied, thank you.

-- 
Dmitry
