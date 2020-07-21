Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7A227FD0
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 14:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGUMT2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 08:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGUMT1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 21 Jul 2020 08:19:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D15221702;
        Tue, 21 Jul 2020 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595333967;
        bh=f47xYJVDLjuHwsEsuV6hymuSt9wQDZBA5/k8Bfez7h4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VRsBW+Qb8OEazZU4kNCmVnUBHpsee+fj7yzI5ateGNItk3nQLnfRKx3gBE4Zw/FNF
         qk8muiFtMQSicKhQHO0fYvSMmWN/fK+egz1l8Y0SczmRUjBKlVSnhd3NivSHOdw37b
         IuTNm0sHcYlH6bbsn2tVZl7Vaex5UWuY1UOr7qas=
Date:   Tue, 21 Jul 2020 13:19:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: core: fix/re-introduce back parent assignment
Message-ID: <20200721131923.4885d87f@archlinux>
In-Reply-To: <CALT56yO842Kt56Dtsd-+YE04-HbH7cQnEQpn6dp+7YhYJ=-hYQ@mail.gmail.com>
References: <20200721102407.134402-1-alexandru.ardelean@analog.com>
        <CALT56yO842Kt56Dtsd-+YE04-HbH7cQnEQpn6dp+7YhYJ=-hYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jul 2020 13:34:19 +0300
Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:

> =D0=B2=D1=82, 21 =D0=B8=D1=8E=D0=BB. 2020 =D0=B3. =D0=B2 13:24, Alexandru=
 Ardelean <alexandru.ardelean@analog.com>:
>  [...] =20
>=20
> Tested-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
>=20
Applied to the togreg branch of iio.git and pushed out as testing.
Current plan is to do a pull request tomorrow so should make it in time
for the merge window.  If it gets delayed for some reason we can send
it as a fix after the merge window.

Thanks,

Jonathan


