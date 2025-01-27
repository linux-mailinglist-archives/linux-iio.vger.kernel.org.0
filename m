Return-Path: <linux-iio+bounces-14612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DACA1D8E8
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FE71886E59
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7725136327;
	Mon, 27 Jan 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQxBegs7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CBF7603F;
	Mon, 27 Jan 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990007; cv=none; b=LDEfEYJWZy5A8wyUjowhMNiJIzrpGwyL/fqF1ZCtmJ0Jn0F5T29wy9wdr5t1nqKZLEAtszebm5hDMsQyBuxDNb58+hUva7/tw/lO3z/dPaYbhU/9KN+bgEC0XKgSLibQ8CEjgli6XZSY/QHlUVLbAovtbX3m192sS1P6ixeJzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990007; c=relaxed/simple;
	bh=kwWDA3rU/cN1R71j7vGPxnBKK1HlIAFQmbB0t+RzmOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or1vn/wZ3je39D9BRh1LH8DbyxyZW8qw60cYK9eddiXZb8pPb6gW8Tb2NcFCT3Ts088Fij5Tue5FTolht37S+5eCkv9e1KcJq7venex8a6mxpXNaImjvE5TNCKXv/a+MhRBHXoUfH4JK3xuWw4KlNCam9Qpsau/yP23ERKXE96M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQxBegs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D289C4CEE1;
	Mon, 27 Jan 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737990006;
	bh=kwWDA3rU/cN1R71j7vGPxnBKK1HlIAFQmbB0t+RzmOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQxBegs7WBv1X6v9R6uZ4y4VWC7i1wv6T0vRcg/AZI6Z1pVGJp6ykCPdx3rrmDEjX
	 P4NYIOez+Mek1EWFaAZk/aVox/bR1ZYYyNTerOPKUXJk+yq0HhOy8vw4n1U+bqTfJZ
	 AHK8io7hDUAlfBxaoHpgHZIYerrjrSwbDz1YF1r7ChOQen17LtQ6eygYXy35pIOro0
	 l4JcDUV2n0tGoOjpUxjlVGc2cPLyN4fuSUTv59iElin3ids3qO1hd7+pAeePLdpPuq
	 obNzopT0ST0SRco6R+3TBGhFxT7PUaXhpxfnlrmJeQkEcrfe7f0XSGtmDcnZ24j5ye
	 vhGXQDcZalJ0w==
Date: Tue, 28 Jan 2025 00:00:02 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, timestamp@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dipen Patel <dipenp@nvidia.com>, dlechner@baylibre.com
Subject: Re: [Q] Frequency & duty cycle measurement?
Message-ID: <Z5efcokgHix-k3lW@ishi>
References: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L5rYZ1lkBZvzecLd"
Content-Disposition: inline
In-Reply-To: <f2ec8a55-42ad-498a-b793-072444dcb92e@prolan.hu>


--L5rYZ1lkBZvzecLd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 04:19:27PM +0100, Cs=F3k=E1s Bence wrote:
> Hi all,
>=20
> we want to measure the frequency and duty cycle of a signal (relating to
> power consumption) using a hardware timer in our SoC (Microchip SAMA5D2).
> The hardware is capable of taking a snapshot of the timer value into anot=
her
> dedicated register pair (RA, RB) on the rising/falling edges, and a small
> `devmem`-based userspace utility was created as a working PoC. Now we want
> to move to a "proper" kernelspace solution.
>=20
> However, none of the existing drivers seem to be able to do this; the
> closest was `drivers/counter/microchip-tcb-capture.c`, but that only seems
> to count one type of edge (rising/falling), and cannot give us the time
> between them, which would be needed for duty cycle calculation. The only
> other driver I could find was `drivers/clocksource/timer-atmel-tcb.c`, wh=
ich
> again seems incapable of such measurements. Therefore, a new module will
> probably be needed; the question then becomes: which API to implement.
>=20
> As `microchip-tcb-capture.c` uses the Generic Counter Interface, that was
> obviously a first stop. However, from what I could see, you can only
> represent (1) the number of times an edge has been encountered, and (2)
> rotary encodings (quadrature and direction-step decoders); and not the ti=
me
> between edges.
>=20
> IIO_ALTVOLTAGE and IIO_CHAN_INFO_FREQUENCY/_PHASE also seemed promising
> (although the lack of IIO_CHAN_INFO_DUTY_CYCLE already posed a problem),
> until I saw that all current drivers are frequency *generators*, and not
> measurers, the latter seems to be completely unimplemented.
>=20
> The only other contender I could find was the Hardware Timestamping Engine
> (HTE), but again, it's not clear whether (1) the API is even capable of
> relaying duty cycle information to userspace and (2) if it is, how would =
one
> go about implementing it.
>=20
> It is also entirely possible I missed a driver or API that could handle t=
his
> better, if so, please don't keep it to yourselves.
>=20
> So, how could one go about implementing such a driver?
>=20
> Bence

Hi Bence,

You could use the Counter chrdev interface to get frequency of counter
events such as rising/falling edges, as well as associating timer values
and snapshots. Do you get an interrupt on each timer snapshot, or is it
just a circular array buffer that gets filled until your purge it? The
implementation might look something like the following.

In the kernel driver, you would push a counter event for each capture; I
assume your hardware issues an interrupt each time a rising/falling edge
occurs:

    static irqreturn_t sama5d2_isr(int irq, void *dev_id)
    {
            struct counter_device *counter =3D dev_id;
            counter_push_event(counter, COUNTER_EVENT_CAPTURE, 0);
            return IRQ_HANDLED;
    }

In the userspace application, you would setup a Counter "watch" to
collect each desired timer value on the respective Counter events; I
assume RA and RB are Count 0 and Count 1 respectively, but if they
represent something else please let me know:

    static struct counter_watch watches[2] =3D {
            {
                    /* Component data: Count 0 count */
                    .component.type =3D COUNTER_COMPONENT_COUNT,
                    .component.scope =3D COUNTER_SCOPE_COUNT,
                    .component.parent =3D 0,
                    /* Event type: Capture */
                    .event =3D COUNTER_EVENT_CAPTURE,
                    /* Device event channel 0 */
                    .channel =3D 0,
            },
            {
                    /* Component data: Count 1 count */
                    .component.type =3D COUNTER_COMPONENT_COUNT,
                    .component.scope =3D COUNTER_SCOPE_COUNT,
                    .component.parent =3D 1,
                    /* Event type: Capture */
                    .event =3D COUNTER_EVENT_CAPTURE,
                    /* Device event channel 0 */
                    .channel =3D 0,
            },
    };
    ...
    int main(void)
    {
            int fd;
            int i;
	    unsigned long long delta_ts, delta_ra, delta_rb;
	    double ra_frequency, rb_frequency, rb_ra;
            struct counter_event first_capture[2], second_capture[2];
           =20
            /* Open Counter chrdev */
            fd =3D open("/dev/counter0", O_RDWR);
           =20
            for (i =3D 0; i < 2; i++) {
	            /* Register all Counter watches */
                    ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
            }
	    /* Start collecting Counter events */
            ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
           =20
            for (;;) {
	        /* Read first Counter event capture */
            	read(fd, first_capture, sizeof(first_capture));
	        /* Read second Counter event capture */
            	read(fd, second_capture, sizeof(second_capture));
               =20
		/* Within each capture, timestamp is the same so only
		 * first element of each capture needs to be compared */
		delta_ts =3D second_capture[0].timestamp - first_capture[0].timestamp;
		/* Compute deltas of timer register pair RA and RB.
		delta_ra =3D second_capture[0].value - first_capture[0].value;
		delta_rb =3D second_capture[1].value - first_capture[1].value;
               =20
		ra_frequency =3D (double)delta_ra / delta_ts;
		rb_frequency =3D (double)delta_rb / delta_ts;
		rb_ra =3D (double)delta_rb / delta_ra;
               =20
            	printf("RA frequency: %ld\n"
		       "RB frequency: %ld\n"
		       "RB per RA: %ld\n"
            	       ra_frequency, rb_frequency, rb_ra);
            }
           =20
            return 0;
    }

If RA and RB are provided as a memory buffer on your device, you can
instead expose them via DEFINE_COUNTER_ARRAY_CAPTURE() such as the
ti-ecap-capture driver does, then perform your userspace computations
by utilizing those respective "capture" array attribute values (via
chrdev like the example above or alternatively via sysfs).

Do you think this design would work for your needs?

William Breathitt Gray

--L5rYZ1lkBZvzecLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ5efcgAKCRC1SFbKvhIj
K3d3AQChNnJh7TbDSsRfyR6M/PqsPlzEiiOD9LM1ho9hnfjDnwEA886rI7ZOW9JN
vfUSJkgvn1NVCBo5qrdZDHO5ORKlAAM=
=zv8x
-----END PGP SIGNATURE-----

--L5rYZ1lkBZvzecLd--

