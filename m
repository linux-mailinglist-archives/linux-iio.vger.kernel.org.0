Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ECB66DF9A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjAQNz3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 08:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjAQNzZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 08:55:25 -0500
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4141A5EA
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 05:55:24 -0800 (PST)
Date:   Tue, 17 Jan 2023 13:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1673963722; x=1674222922;
        bh=ypn8pvHzKOBcDzFNwBNoglPIHTH1Kit0iJGdmWqd7U4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=uHeMoWWGUobBFbD3OixhYKeEgUirqjkX0xeHRJf8SOpxhud0sC9NAez4Yv1JCgmOV
         Q64uLjhTnOnMje3BesSsirC3rSW22rAK0owVtojhe+FKwI1uKkCKi8GFNekjwmVATM
         BRSpcGsUOzrJBXBtqhcKKMLXvdgmM/5sofIIF62BMu/OZY0aRmHoH9vrNmCX5K8b+m
         hKiYYJ1cI/n+0OeV300dmIhD5ZbgOIfsK+Y9SMGdgDr5nqKqtr/zHVjMPJeNuPcHaa
         2yXwcpaAe7PU294bWmMlnmo9lQpXhcMM4tnF/MNaVDyD18gz6RSjcCACMVWVyVFO+i
         DYG7I9jtMdFvA==
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
From:   Wahaj <wahajaved@protonmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org
Subject: Re: CM32181 Bug Report (Linux 6.0+)
Message-ID: <57YVzRHLhBqRMH-lBFzcOxWrOyPUfu0BovpHD2gG-KiCsezDQGoirhBRna4fkQT7GrivgDJkWq1GTWZGf9GsSBw28HXSibWa0jWBEm7DiE0=@protonmail.com>
In-Reply-To: <CAAd53p6ZRr5_FGgdEki+GA0FTJZ7q8g0epcH8BT_XEMUO42EHQ@mail.gmail.com>
References: <k0IjFnlIUFDGe3OlkvevaSjhOZclaX1X6Sskt5vhLQIv9_WeRYNZ--2gUYu67qsxY9WNu1DnH6h4lIx1UPnG4vAY4j7KuqVlq52RN0lC9dg=@protonmail.com> <CAAd53p6vT38y0UVMYuE3V4q07gk0wA=e18x9k3ATu_EvXWB8rA@mail.gmail.com> <8sH16OwIJbnTXpjBaNVGn7Qpv1HmPww_fiXBQ2EfhLkhjWnf90kGxXKfHhyZX9Eu2JqsozqOFWEk3smuGqYxkSZNxEPHTkTTjBc2n7ksRhw=@protonmail.com> <20230108124654.514a5b1b@jic23-huawei> <CAAd53p5nz0ehBmg05njKRG7cnBQQgJFpT-1oqDtajSY8Zz0NMw@mail.gmail.com> <8egyl6OawVGTgDhMmArrWCKWVTp4CxDO3jFgEMjWvk11qEyFVARwV0xoGpwBvB4CHiIVWhXth_2CKznGgCvXxFbPsrIpSwYCn_QSx4aezrk=@protonmail.com> <cKYeY4HN3_NekeCl1PMBnzcn-Y64OEXNKTrGyYf3wQQekbNLzQeM5TlsB1rrGlsRSjVxnGJ84CytQ0w2VhFAoAGIrYMZnvqq0XGsnyy71L8=@protonmail.com> <ozK9iquIv9o2or9IunOcfXJEvbVPwunC15iEe6DlT8ObOWI_wNFnJtN0lubBXEkln6pm8bp939ex7YlmEZhoxDF9nU6nKu4QkqwBkkHqJw8=@protonmail.com> <CAAd53p6ZRr5_FGgdEki+GA0FTJZ7q8g0epcH8BT_XEMUO42EHQ@mail.gmail.com>
Feedback-ID: 13756336:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Kai Hen

------- Original Message -------
On Tuesday, January 17th, 2023 at 1:19 PM, Kai-Heng Feng <kai.heng.feng@can=
onical.com> wrote:
> Hi Wahaj,
>=20
> [snipped]
>=20
> > Hi Kai-Heng
> >=20
> > I have found some weird stuff going on while applying some changes. PFA=
 a patch for your reference
> >=20
> > System goes to suspend, fans immediately slow down, unlike the vanilla =
v6.x kernel, the screen doesn't wake up immediately, the fans stop spinning=
 completely after about 4 minutes and does not wake back up along with powe=
r button light on (not normal), have to force reboot after suspending
> >=20
> > Here are the jounralctl logs after closing lid
> >=20
> > - systemd[1]: Reached target Sleep.
> > - systemd[1]: Starting System Suspend...
> > - systemd-sleep[2150]: Entering sleep state 'suspend'...
> >=20
> > The following entry only appears after the 4 minute mark when fans shut=
 off
> >=20
> > - kernel: PM: suspend entry (deep)
> >=20
> > I think the issue may have something to do with how the iio device is i=
nitialized. Are there any differences between the various ways of fetching =
the i2c client from the device struct?
> >=20
> > Also, the logs do not get printed in the suspend and resume entrypoints=
 do not get printed
>=20
>=20
> I think I found what went wrong. There are two i2c clients for
> systems with ARA.
>=20
> Please give the following patch a try:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1988346/comments/53
>=20

The patch does indeed work, and system goes to suspend and back without a p=
roblem

Thanks
Wahaj Javed

> Kai-Heng
>=20
> > Best Regards
> > Wahaj Javed
> >=20
> > > > > Kai-Heng
> > > > >=20
> > > > > > Jonathan
> > > > > >=20
> > > > > > > I would like to take on this bug and try to solve it if that'=
s possible
> > > > > > >=20
> > > > > > > Best Regards
> > > > > > > Wahaj Javed
