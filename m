Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161E11D6843
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEQNk3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 09:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgEQNk3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 09:40:29 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE67E205CB;
        Sun, 17 May 2020 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589722828;
        bh=G0P6+y8iQnmm0nku8Ah9w1QD2h0NRh44towCMiN6WTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t8fKDRc7S6TWzLK2LGsw5SFxdikcBC0SlMpskHx7mYLelWq3TMFu+VEvJEIs3N0TA
         2FL16c++stxC3ReSeZq1ZrfXkIOxKcKRPtPtkEuggVDCEuZI/C8Df5VRZTMiftEQq2
         vsMQ5uZiNFxr46spmYy6Y6deFWamYJ4FguuDxPOo=
Date:   Sun, 17 May 2020 14:40:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 00/14] iio: buffer: add support for multiple buffers
Message-ID: <20200517144023.6c5cb169@archlinux>
In-Reply-To: <0727f57d1faccb08dff24b6f9343754f3598e76e.camel@analog.com>
References: <20200508135348.15229-1-alexandru.ardelean@analog.com>
        <a9a47e84-b933-cca6-dcfb-d97a51c8bdd4@metafoo.de>
        <20200510110958.29046a18@archlinux>
        <8c5d9ef5ed4ea9037c5459daa2044d1cd7c5db7a.camel@analog.com>
        <c88b17c3-a9d6-e755-04e8-bc9f225e2a3b@metafoo.de>
        <554fe46f0cdd1cafb313f534c0edd93f5686b806.camel@analog.com>
        <7d2c8174e345bf8e241d48de65066d2606143503.camel@analog.com>
        <9ae7e69b-f4ce-dd2b-d70b-2aac66b19814@metafoo.de>
        <04fda2eb89244dd2bf8e024d4b4405eceffd016c.camel@analog.com>
        <fb6cc3f4-b133-4ba4-a8fb-84349355ebc3@metafoo.de>
        <a85270a78093c78cf90d7503f1652da66b6dd28b.camel@analog.com>
        <9e88fd9640ccd9a8d1e3a45a4e328797a7d3a9bf.camel@analog.com>
        <20200516172445.7f0d96cb@archlinux>
        <0727f57d1faccb08dff24b6f9343754f3598e76e.camel@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 May 2020 06:26:17 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Sat, 2020-05-16 at 17:24 +0100, Jonathan Cameron wrote:
> > [External]
> >=20
> > On Sat, 16 May 2020 13:08:46 +0000
> > "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
> >  =20
> > > On Tue, 2020-05-12 at 06:26 +0000, Ardelean, Alexandru wrote: =20
> > > > [External]
> > > >=20
> > > > On Mon, 2020-05-11 at 21:56 +0200, Lars-Peter Clausen wrote:   =20
> > > > > [External]
> > > > >=20
> > > > > On 5/11/20 4:56 PM, Ardelean, Alexandru wrote:   =20
> > > > > > On Mon, 2020-05-11 at 15:58 +0200, Lars-Peter Clausen wrote:   =
=20
> > > > > > > [External]
> > > > > > >=20
> > > > > > > On 5/11/20 3:24 PM, Ardelean, Alexandru wrote:   =20
> > > > > > > > On Mon, 2020-05-11 at 13:03 +0000, Ardelean, Alexandru wrot=
e:   =20
> > > > > > > > > [External]
> > > > > > > > >=20
> > > > > > > > > On Mon, 2020-05-11 at 12:37 +0200, Lars-Peter Clausen wro=
te:   =20
> > > > > > > > > > [External]
> > > > > > > > > >=20
> > > > > > > > > > On 5/11/20 12:33 PM, Ardelean, Alexandru wrote:   =20
> > > > > > > > > > > On Sun, 2020-05-10 at 11:09 +0100, Jonathan Cameron w=
rote:   =20
> > > > > > > > > > > > [External]
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Sat, 9 May 2020 10:52:14 +0200
> > > > > > > > > > > > Lars-Peter Clausen <lars@metafoo.de> wrote:
> > > > > > > > > > > >    =20
> > > > > > > > > > > > > On 5/8/20 3:53 PM, Alexandru Ardelean wrote:   =20
> > > > > > > > > > > > > > [...]
> > > > > > > > > > > > > > What I don't like, is that iio:device3 has
> > > > > > > > > > > > > > iio:buffer3:0
> > > > > > > > > > > > > > (to
> > > > > > > > > > > > > > 3).
> > > > > > > > > > > > > > This is because the 'buffer->dev.parent =3D
> > > > > > > > > > > > > > &indio_dev-   =20
> > > > > > > > > > > > > > > dev'.   =20
> > > > > > > > > > > > > > But I do feel this is correct.
> > > > > > > > > > > > > > So, now I don't know whether to leave it like t=
hat or
> > > > > > > > > > > > > > symlink to
> > > > > > > > > > > > > > shorter
> > > > > > > > > > > > > > versions like 'iio:buffer3:Y' ->
> > > > > > > > > > > > > > 'iio:device3/bufferY'.
> > > > > > > > > > > > > > The reason for naming the IIO buffer devices to
> > > > > > > > > > > > > > 'iio:bufferX:Y'
> > > > > > > > > > > > > > is
> > > > > > > > > > > > > > mostly to make the names unique. It would have =
looked
> > > > > > > > > > > > > > weird
> > > > > > > > > > > > > > to
> > > > > > > > > > > > > > do
> > > > > > > > > > > > > > '/dev/buffer1' if I would have named the buffer
> > > > > > > > > > > > > > devices
> > > > > > > > > > > > > > 'bufferX'.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > So, now I'm thinking of whether all this is
> > > > > > > > > > > > > > acceptable.
> > > > > > > > > > > > > > Or what is acceptable?
> > > > > > > > > > > > > > Should I symlink 'iio:device3/iio:buffer3:0' ->
> > > > > > > > > > > > > > 'iio:device3/buffer0'?
> > > > > > > > > > > > > > What else should I consider moving forward?
> > > > > > > > > > > > > > What means forward?
> > > > > > > > > > > > > > Where did I leave my beer?   =20
> > > > > > > > > > > > > Looking at how the /dev/ devices are named I thin=
k we
> > > > > > > > > > > > > can
> > > > > > > > > > > > > provide
> > > > > > > > > > > > > a
> > > > > > > > > > > > > name
> > > > > > > > > > > > > that is different from the dev_name() of the devi=
ce.
> > > > > > > > > > > > > Have a
> > > > > > > > > > > > > look
> > > > > > > > > > > > > at
> > > > > > > > > > > > > device_get_devnode() in drivers/base/core.c. We s=
hould
> > > > > > > > > > > > > be
> > > > > > > > > > > > > able
> > > > > > > > > > > > > to
> > > > > > > > > > > > > provide the name for the chardev through the devn=
ode()
> > > > > > > > > > > > > callback.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > While we are at this, do we want to move the new =
devices
> > > > > > > > > > > > > into
> > > > > > > > > > > > > an
> > > > > > > > > > > > > iio
> > > > > > > > > > > > > subfolder? So iio/buffer0:0 instead of iio:buffer=
0:0?   =20
> > > > > > > > > > > > Possibly on the folder.  I can't for the life of me
> > > > > > > > > > > > remember
> > > > > > > > > > > > why
> > > > > > > > > > > > I
> > > > > > > > > > > > decided
> > > > > > > > > > > > not to do that the first time around - I'll leave i=
t at
> > > > > > > > > > > > the
> > > > > > > > > > > > mysterious "it may turn out to be harder than you'd
> > > > > > > > > > > > think..."
> > > > > > > > > > > > Hopefully not ;)   =20
> > > > > > > > > > > I was also thinking about the /dev/iio subfolder whil=
e doing
> > > > > > > > > > > this.
> > > > > > > > > > > I can copy that from /dev/input
> > > > > > > > > > > They seem to do it already.
> > > > > > > > > > > I don't know how difficult it would be. But it looks =
like a
> > > > > > > > > > > good
> > > > > > > > > > > precedent.   =20
> > > > > > > > > > All you have to do is return "iio/..." from the devnode=
()
> > > > > > > > > > callback.   =20
> > > > > > > > > I admit I did not look closely into drivers/input/input.c=
 before
> > > > > > > > > mentioning
> > > > > > > > > this
> > > > > > > > > as as good precedent.
> > > > > > > > >=20
> > > > > > > > > But, I looks like /dev/inpput is a class.
> > > > > > > > > While IIO devices are a bus_type devices.
> > > > > > > > > Should we start implementing an IIO class? or?   =20
> > > > > > > > What I should have highlighted [before] with this, is that =
there
> > > > > > > > is no
> > > > > > > > devnode()
> > > > > > > > callback for the bus_type [type].   =20
> > > > > > > But there is one in device_type :)   =20
> > > > > > Many thanks :)
> > > > > > That worked nicely.
> > > > > >=20
> > > > > > I now have:
> > > > > >=20
> > > > > > root@analog:~# ls /dev/iio/*
> > > > > > /dev/iio/iio:device0  /dev/iio/iio:device1
> > > > > >=20
> > > > > > /dev/iio/device3:
> > > > > > buffer0  buffer1  buffer2  buffer3
> > > > > >=20
> > > > > > /dev/iio/device4:
> > > > > > buffer0
> > > > > >=20
> > > > > >=20
> > > > > > It looks like I can shift these around as needed.
> > > > > > This is just an experiment.
> > > > > > I managed to move the iio devices under /dev/iio, though probab=
ly the
> > > > > > IIO
> > > > > > devices will still be around as /dev/iio:deviceX for legacy rea=
sons.
> > > > > >=20
> > > > > > Two things remain unresolved.
> > > > > > 1. The name of the IIO buffer device.
> > > > > >=20
> > > > > > root@analog:/sys/bus/iio/devices# ls iio\:device3/
> > > > > > buffer          in_voltage0_test_mode           name
> > > > > > events          in_voltage1_test_mode           of_node
> > > > > > iio:buffer:3:0  in_voltage_sampling_frequency   power
> > > > > > iio:buffer:3:1  in_voltage_scale                scan_elements
> > > > > > iio:buffer:3:2  in_voltage_scale_available      subsystem
> > > > > > iio:buffer:3:3  in_voltage_test_mode_available  uevent
> > > > > >=20
> > > > > >=20
> > > > > > Right now, each buffer device is named 'iio:buffer:X:Y'.
> > > > > > One suggesttion was  'iio:deviceX:bufferY'
> > > > > > I'm suspecting the latter is preferred as when you sort the fol=
ders,
> > > > > > buffers
> > > > > > come right after the iio:deviceX folders in /sys/bus/iio/device=
s.
> > > > > >=20
> > > > > > I don't feel it matters much the device name of the IIO buffer =
if we
> > > > > > symlink
> > > > > > it
> > > > > > to a shorter form.
> > > > > >  =20
> > > > > > I'm guessing, we symlink these devices to short-hand 'bufferY' =
folders
> > > > > > in
> > > > > > each
> > > > > > 'iio:deviceX'?   =20
> > > > >=20
> > > > > I think that would be a bit excessive. Only for the legacy buffer=
 we=20
> > > > > need to have a symlink.
> > > > >    =20
> > > > > > [...]
> > > > > > 2. I know this is [still] stupid now; but any suggestions one h=
ow to
> > > > > > symlink
> > > > > > /dev/iio:device3 -> /dev/iio/device3/buffer0 ?
> > > > > >    =20
> > > > > Does not seem to be possible. Userspace will have to take care of=
 it.=20
> > > > > This means we need to keep legacy devices in /dev/ and only new b=
uffers=20
> > > > > in /dev/iio/.   =20
> > > >=20
> > > > One thought about this, was that we keep the chardev for the IIO de=
vice
> > > > for
> > > > this.
> > > > i.e.  /dev/iio:deviceX and /dev/iio/deviceX/buffer0 open the same b=
uffer.
> > > > This means that for a device with 4 buffers, you get 5 chardevs.
> > > > This also seems a bit much/excessive. Maybe also in terms of source=
-code.
> > > > It would at least mean not moving the event-only chardev to 'indust=
rialio-
> > > > event.c', OR move it, and have the same chardev in 3 places
> > > > ['industrialio-
> > > > event.c', 'industrialio-buffer.c' & 'industrialio-buffer.c'
> > > >=20
> > > > Maybe this sort-of makes sense to have for a few years/kernel-revis=
ions
> > > > until
> > > > things clean-up.
> > > >=20
> > > > I guess at this point, the maintainer should have the final say abo=
ut
> > > > this.   =20
> > >=20
> > > Another 'compromise' idea, is that we make this '/dev/iio/deviceX/buf=
ferY'
> > > thing
> > > a feature for new devices, and leave '/dev/iio:deviceX' devices [for
> > > buffers] a
> > > thing for current devices.
> > > It would mean adding a 'new' iio_device_attach_buffer(); no idea on a=
 name
> > > [for
> > > this yet]. =20
> >=20
> > Definitely a no to that.  If we make this transition it needs to be
> > automatic and subsystem wide.  At some point we could have a kconfig op=
tion
> > to disable the legacy interface subsystem wise as a precursor to eventu=
ally
> > dropping it. =20
> >  =20
> > > Over time, people can convert existing drivers to the new IIO-buffer =
format,
> > > if
> > > they want to. That also gives them a bit better control over symlinki=
ng
> > > '/dev/iio:deviceX' -> '/dev/iio/deviceX/bufferY' [or symlinking in re=
verse
> > > if
> > > they want to].
> > >=20
> > > That may create confusion I guess during a transition period.
> > > And it would [ideally] have a mechanism [preferably at build/compile =
time]
> > > to
> > > notify users to use the new IIO buffer mechanism [vs the old one] when
> > > adding
> > > new drivers.
> > > Otherwise, there's the risk of people copying the old IIO buffer mech=
anism.
> > > This can be brought-up at review, but =C2=AF\_(=E3=83=84)_/=C2=AF ; i=
t can be annoying. =20
> >=20
> > If we can't do this in a transparent fashion we need to rethink.
> > The existing interface 'has' to remain and do something sensible.
> > Realistically
> > we need to keep it in place for 3-5 years at least.
> >=20
> > I'm not yet convinced the complexity is worthwhile.  We 'could' fallbac=
k to
> > the same trick used for events and use an ioctl to access all buffers
> > other than the first one...  Then we retain one chardev per iio device
> > and still get the flexibility we need to have multiple buffers.
> > In some ways it is tidier, even if a bit less intuitive...
> > If we can't build the symlinks we were all kind of assuming we could
> > we may need to rethink the overall path.
> >=20
> > Anyhow, you are doing great work exploring the options! =20
>=20
> I wonder if you got to read the idea about adding more chardevs.
>=20
> The one where /dev/iio:deviceX & /dev/iio/deviceX/buffer0 open the same b=
uffer
> object. I'm not sure about any race issues here.
> The bad-part [I feel] is that we get more duplication on chardev file_ope=
rations
> (open, release, ioctl, etc).
> We need to re-wrap code-paths so that they open the same buffer.
> And the number of chardevs per IIO device increases by 1 (for a device wi=
th 4
> buffers =3D=3D 4 chardevs + 1 legacy)

I read that one and it strikes me as a hack.  Two interfaces to the same
thing is always a bad idea if we can possibly avoid it.  I was happy enough
with a link if that was doable because then they are the same device with
same dev-node etc.  Though thinking more on that it will be hard to get
all the relevant links in place.


>=20
> I kinda like the idea of the /dev/iio/ folder. But I'm not strongly opini=
onated
> towards it either.
> This also allows some /dev/iio/deviceX/eventY chardevs.
> And some other types of chardevs /dev/iio/deviceX/somethingNewY

That expansion of chrdevs is kind of what worries me.  We end up with
more and more of them.

>=20
> But, if I think about it, the only benefit of this [over anon inodes for
> chardevs] is that it allows us to do direct access via cat/echo to the ac=
tual
> chardev of the buffer.
> Then, there's also the fact that adding more chardevs increases complexit=
y to
> userspace, so it won't matter much. People would probably prefer some use=
rspace
> IIO library to do the data read/write.
>=20
> I'm getting the feeling now that the final debathe is 'anon inodes or not'

Yes, I think that is the big question.  Without your work to explore
the options we wouldn't really know what the other options were.=20

I'm far from sure what the 'right' answer is to this.

So there is another corner case we should think about.  What do we
do about the devices that current expose multiple buffers by having multiple
IIO devices?  Usually that occurs for devices that can do weird interleaving
in hardware fifos - hence can produce some channels at N times the frequenc=
y of
others - or where we have one shared stream with tagged data.

I suspect it's going to be really hard to map those across to the new inter=
face
with any sort of backwards compatibility.  They expose complete iio devices
with all the infrastructure that entails.  Maybe we just leave them alone?

J

>=20
> Thoughts here?
>=20
>=20
> >=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> >  =20
> > >  =20
> > > >    =20
> > > > >    =20

