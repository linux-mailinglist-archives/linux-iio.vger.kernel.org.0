Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEE23A57EB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhFMLIu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 07:08:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFMLIu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 07:08:50 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71DB56108E;
        Sun, 13 Jun 2021 11:06:47 +0000 (UTC)
Date:   Sun, 13 Jun 2021 12:08:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH 2/2] counter: intel-qep: Use to_pci_dev() helper
Message-ID: <20210613120845.48160e47@jic23-huawei>
In-Reply-To: <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
References: <20210611115558.796338-1-jarkko.nikula@linux.intel.com>
        <20210611115558.796338-2-jarkko.nikula@linux.intel.com>
        <CAHp75VfBoOvGp7O3-WSWFuXGbQP0EbSQYaJi5B28oBkazkV8+w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 13 Jun 2021 13:36:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 11, 2021 at 2:57 PM Jarkko Nikula
> <jarkko.nikula@linux.intel.com> wrote:
> >
> > Use to_pci_dev() helper instead of container_of(d, struct pci_dev, dev);  
> 
> ...
> 
> > -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> > +       struct pci_dev *pdev = to_pci_dev(dev);
> >         struct intel_qep *qep = pci_get_drvdata(pdev);  
> 
> Why not change both lines to dev_get_drvdata()?
> 
> > -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> > +       struct pci_dev *pdev = to_pci_dev(dev);
> >         struct intel_qep *qep = pci_get_drvdata(pdev);  
> 
> Ditto
> 
Question when doing this is whether it is better to pair pci_get_drvdata
with pci_set_drvdata rather than assuming it will always map to dev_get_drvdata().

I personally don't feel too strongly about this either way, but I know
others are unhappy with mixing them.

Of course, could use dev_set_drvdata() in the first place then it would be less
of an issue.

Jonathan

